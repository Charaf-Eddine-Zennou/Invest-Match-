import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, OneToMany, CreateDateColumn, JoinColumn } from 'typeorm';
import { User } from './user.entity';
import { Company } from './company.entity';
import { CommentLike } from './comment-like.entity';

@Entity('comments')
export class Comment {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User, user => user.comments)
  @JoinColumn({ name: 'user_id' })
  user: User;

  @ManyToOne(() => Company, company => company.comments)
  @JoinColumn({ name: 'company_id' })
  company: Company;

  @Column()
  content: string;

  @OneToMany(() => CommentLike, like => like.comment, { cascade: true })
  likes: CommentLike[];

  @CreateDateColumn()
  created_at: Date;
}
