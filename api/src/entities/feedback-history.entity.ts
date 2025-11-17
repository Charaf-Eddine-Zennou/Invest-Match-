import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity({ name: 'feedback_history' })
export class FeedbackHistory {
  @PrimaryGeneratedColumn()
  id: string;

  @Column({ type: 'varchar', length: 36 })
  user_id: string;

  @Column({ type: 'varchar', length: 36 })
  company_id: string;

  @Column({ type: 'varchar', length: 10 })
  feedback: 'like' | 'dislike';

  @CreateDateColumn({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;
}