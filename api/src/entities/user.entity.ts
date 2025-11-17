
import { Entity, PrimaryColumn, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { Comment } from './comment.entity';
import { CommentLike } from './comment-like.entity';
import { Message } from './message.entity';
import { Company } from './company.entity';

export enum Niveau {
  DEBUTANT = 'debutant',
  INTERMEDIAIRE = 'intermediaire',
  AVANCE = 'avance',
}

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  user_id: string;
  
  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255, unique: true })
  email: string;

  @Column({ type: 'varchar', length: 255 })
  password: string;

  @Column({ type: 'enum', enum: Niveau })
  niveau: Niveau;

    @OneToMany(() => Comment, (comment) => comment.user)
  comments: Comment[];

    @OneToMany(() => CommentLike, (like) => like.user)
  likes: CommentLike[];


  @Column({ type: 'json', nullable: true })
  secteurs_pref: string[];

  @Column({ type: 'varchar', length: 255, nullable: true })
  modele_eco_pref: string;

  @Column({ type: 'bigint', nullable: true })
  budget_min: number;

  @Column({ type: 'bigint', nullable: true })
  budget_max: number;

  @Column({ type: 'int', nullable: true })
  taille_min: number;

  @Column({ type: 'int', nullable: true })
  taille_max: number;

  @Column({ type: 'json', nullable: true })
  seed_pref: string[];

  @Column({ type: 'float', nullable: true })
  valo_pre_min: number;

  @Column({ type: 'float', nullable: true })
  valo_pre_max: number;

  @Column({ type: 'float', nullable: true })
  valo_post_min: number;

  @Column({ type: 'float', nullable: true })
  valo_post_max: number;

  @Column({ type: 'varchar', length: 255, nullable: true })
  location_city: string;

  @Column({ type: 'float', nullable: true })
  location_lat: number;

  @Column({ type: 'float', nullable: true })
  location_lon: number;

    @OneToMany(() => Company, (company) => company.creator)
  companies: Company[];



  @OneToMany(() => Message, (message) => message.sender)
sentMessages: Message[];

@OneToMany(() => Message, (message) => message.receiver)
receivedMessages: Message[];



  @Column({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;
}
