// src/comment/comment.module.ts
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CommentController } from './comment.controller';
import { CommentService } from './comment.service';
import { Comment } from 'src/entities/comment.entity';
import { User } from 'src/entities/user.entity';
import { Company } from 'src/entities/company.entity';
import { CommentLike } from 'src/entities/comment-like.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Comment, User, Company, CommentLike])
  ],
  controllers: [CommentController],
  providers: [CommentService]
})
export class CommentModule {}
