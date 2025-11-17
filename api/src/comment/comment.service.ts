import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Comment } from "src/entities/comment.entity";
import { User } from "src/entities/user.entity";
import { Company } from "src/entities/company.entity";
import { CommentLike } from "src/entities/comment-like.entity";

@Injectable()
export class CommentService {
  constructor(
    @InjectRepository(Comment) private commentRepo: Repository<Comment>,
    @InjectRepository(User) private userRepo: Repository<User>,
    @InjectRepository(Company) private companyRepo: Repository<Company>,
    @InjectRepository(CommentLike) private commentLikeRepo: Repository<CommentLike>,
  ) {}

  async getCommentsByCompany(companyId: string) {
    const comments = await this.commentRepo.find({
      where: { company: { company_id: companyId } },
      relations: ['user', 'company', 'likes'],
      order: { created_at: 'DESC' },
    });

    return comments.map(comment => ({
      ...comment,
      likeCount: comment.likes.length,
    }));
  }

  async addComment(userId: string, companyId: string, content: string) {
    const user = await this.userRepo.findOneBy({ user_id: userId });
    const company = await this.companyRepo.findOneBy({ company_id: companyId });

    if (!user) throw new NotFoundException("Utilisateur introuvable");
    if (!company) throw new NotFoundException("Entreprise introuvable");

    const comment = this.commentRepo.create({ user, company, content });
    return this.commentRepo.save(comment);
  }

  async likeComment(commentId: string, userId: string) {
  const comment = await this.commentRepo.findOne({
    where: { id: commentId },
    relations: ['likes', 'likes.user'], 
  });
  if (!comment) throw new NotFoundException("Commentaire introuvable");

  const user = await this.userRepo.findOneBy({ user_id: userId });
  if (!user) throw new NotFoundException("Utilisateur introuvable");

  const alreadyLiked = comment.likes?.find(like => like.user.user_id === userId);

  if (alreadyLiked) {
    await this.commentRepo.manager.delete(CommentLike, { id: alreadyLiked.id });
  } else {
    const like = this.commentRepo.manager.create(CommentLike, { user, comment });
    await this.commentRepo.manager.save(CommentLike, like);
  }

  const updated = await this.commentRepo.findOne({
    where: { id: commentId },
    relations: ['likes', 'likes.user'],
  });

  return {
    commentId: updated.id,
    likes: updated.likes.length,
    likedByCurrentUser: !alreadyLiked,
  };
}

}
