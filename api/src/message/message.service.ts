import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Message } from 'src/entities/message.entity';
import { Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';

@Injectable()
export class MessageService {
  constructor(
    @InjectRepository(Message)
    private messageRepo: Repository<Message>,
  ) {}

  async createMessage(content: string, senderId: string, receiverId: string) {
    const message = this.messageRepo.create({
      content,
      sender: { user_id: senderId } as User,
      receiver: { user_id: receiverId } as User,
    });
    return this.messageRepo.save(message);
  }

  findMessages(senderId: string, receiverId: string) {
    return this.messageRepo.find({
      where: [
        { sender: { user_id: senderId }, receiver: { user_id: receiverId } },
        { sender: { user_id: receiverId }, receiver: { user_id: senderId } },
      ],
      relations: ['sender', 'receiver'],
      order: { createdAt: 'ASC' },
    });
  }

  async findConversations(userId: string) {
    const messages = await this.messageRepo.find({
      where: [
        { sender: { user_id: userId } },
        { receiver: { user_id: userId } },
      ],
      relations: ['sender', 'receiver'],
      order: { createdAt: 'DESC' },
    });

    const interlocuteurs = new Map<string, any>();
    messages.forEach(msg => {
      if (msg.sender.user_id !== userId) {
        interlocuteurs.set(msg.sender.user_id, msg.sender);
      }
      if (msg.receiver.user_id !== userId) {
        interlocuteurs.set(msg.receiver.user_id, msg.receiver);
      }
    });

    return Array.from(interlocuteurs.values());
  }
}
