// src/entities/tableau-seed.entity.ts
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('tableau_seed')
export class TableauSeed {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  niveau: string;

  @Column()
  seed: string;

  @Column({ type: 'float' })
  poids: number;
}
