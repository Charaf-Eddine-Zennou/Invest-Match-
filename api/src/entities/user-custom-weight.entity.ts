
import { Entity, PrimaryColumn, UpdateDateColumn, Column, CreateDateColumn } from 'typeorm';

@Entity({ name: 'user_custom_weights' })
export class UserCustomWeight {
  @PrimaryColumn({ type: 'varchar', length: 36 })
  user_id: string;

  @PrimaryColumn({ type: 'varchar', length: 50 })
  critere: string;

  @Column({ type: 'float' })
  poids_personnalise: number;

@UpdateDateColumn({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
updated_at: Date;
}
