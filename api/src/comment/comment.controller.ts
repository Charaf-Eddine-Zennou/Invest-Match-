import { Controller, Get, Post, Param, Body, ParseUUIDPipe, Put } from '@nestjs/common';
import { CommentService } from './comment.service';

@Controller('comments')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @Get('company/:companyId')
  getCommentsByCompany(@Param('companyId', new ParseUUIDPipe()) companyId: string) {
    return this.commentService.getCommentsByCompany(companyId);
  }

  @Post('company/:companyId')
  addComment(
    @Param('companyId', new ParseUUIDPipe()) companyId: string,
    @Body('userId') userId: string,
    @Body('content') content: string,
  ) {
    return this.commentService.addComment(userId, companyId, content);
  }

  @Put(':id/like/:userId')
  likeComment(
    @Param('id') commentId: string,
    @Param('userId') userId: string
  ) {
    return this.commentService.likeComment(commentId, userId);
  }
}
