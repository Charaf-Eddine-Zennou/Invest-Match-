import { Entity, PrimaryColumn, Column, CreateDateColumn } from 'typeorm';

@Entity({ name: 'user_seed_preferences' })
export class UserSeedPreference {
  @PrimaryColumn({ type: 'varchar', length: 36 })
  user_id: string;

  @PrimaryColumn({ type: 'varchar', length: 255 })
  seed: string;

  @Column({ type: 'float' })
  score: number;

  @Column({ type: 'int' })
  likes_count: number;

  @Column({ type: 'int' })
  dislikes_count: number;

  @CreateDateColumn({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;
}