// src/feedback/feedback.controller.ts
import { Controller, Post, Body, ConflictException } from '@nestjs/common';
import { FeedbackService } from './feedback.service';
import { CreateFeedbackDto } from './dto/create-feedback.dto';

@Controller('api/feedback')
export class FeedbackController {
  constructor(private readonly feedbackService: FeedbackService) {}

  @Post()
  async handleFeedback(@Body() dto: CreateFeedbackDto) {
    const result = await this.feedbackService.handleFeedback(dto);
    if (result === 'exists') {
      throw new ConflictException('Feedback déjà enregistré.');
    }
    return { message: 'Feedback enregistré avec succès.' };
  }
}
