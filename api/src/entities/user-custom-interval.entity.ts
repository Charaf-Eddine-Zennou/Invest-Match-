import { Entity, PrimaryColumn, Column, CreateDateColumn } from 'typeorm';

@Entity({ name: 'user_custom_intervals' })
export class UserCustomInterval {
  @PrimaryColumn({ type: 'varchar', length: 36 })
  user_id: string;

  @PrimaryColumn({ type: 'varchar', length: 50 })
  critere: string;

  @Column({ type: 'float' })
  borne_min: number;

  @Column({ type: 'float' })
  borne_max: number;

  @CreateDateColumn({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;
}