// src/feedback/dto/create-feedback.dto.ts
import { IsUUID, IsString, IsIn } from 'class-validator';

export class CreateFeedbackDto {
  @IsUUID()
  user_id: string;

  @IsUUID()
  company_id: string;

  @IsIn(['like', 'dislike'])
  feedback: 'like' | 'dislike';
}
