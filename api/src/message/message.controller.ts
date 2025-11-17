import { Controller, Post, Get, Body, Query } from '@nestjs/common';
import { MessageService } from './message.service';

@Controller('messages')
export class MessageController {
  constructor(private readonly messageService: MessageService) {}

  @Post()
  async sendMessage(
    @Body('content') content: string,
    @Body('senderId') senderId: string,
    @Body('receiverId') receiverId: string,
  ) {
    return this.messageService.createMessage(content, senderId, receiverId);
  }

  @Get()
  async getMessages(
    @Query('senderId') senderId: string,
    @Query('receiverId') receiverId: string,
  ) {
    return this.messageService.findMessages(senderId, receiverId);
  }

  
@Get('conversations')
async getConversations(@Query('userId') userId: string) {
  return this.messageService.findConversations(userId);
}

}
