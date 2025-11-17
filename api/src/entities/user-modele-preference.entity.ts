import { Entity, PrimaryColumn, Column, CreateDateColumn } from 'typeorm';

@Entity({ name: 'user_modele_preferences' })
export class UserModelePreference {
  @PrimaryColumn({ type: 'varchar', length: 36 })
  user_id: string;

  @PrimaryColumn({ type: 'varchar', length: 255 })
  modele_eco: string;

  @Column({ type: 'float' })
  score: number;

  @Column({ type: 'int' })
  likes_count: number;

  @Column({ type: 'int' })
  dislikes_count: number;

  @CreateDateColumn({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;
}