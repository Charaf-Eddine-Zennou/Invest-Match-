import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn } from 'typeorm';
import { Comment } from './comment.entity';
import { User } from './user.entity';

@Entity({ name: 'companies' })
export class Company {

  @PrimaryGeneratedColumn('uuid')
  company_id: string;

  @Column({ name: 'company_email', nullable: true })
  company_email: string;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255 })
  secteur: string;

  @Column({ type: 'bigint', transformer: { to: (v: number) => v, from: (v: string) => Number(v) } })
  montant: number;

  @Column({ type: 'int' })
  taille: number;

  @Column({ type: 'varchar', length: 50 })
  seed: string;

  @Column({ type: 'float', nullable: true })
  latitude: number;

  @Column({ type: 'float', nullable: true })
  longitude: number;

  @Column({ type: 'varchar', length: 100 })
  modele_eco: string;

  @Column({ type: 'float', nullable: true })
  valo_pre: number | null;

  @Column({ type: 'float', nullable: true })
  valo_post: number | null;

  @Column({ name: 'videoUrl', type: 'varchar', nullable: true })
  videoUrl: string;



  @ManyToOne(() => User, (user) => user.companies, { nullable: true })
  @JoinColumn({ name: 'creatorId' })
  creator: User;

  @OneToMany(() => Comment, (comment) => comment.company)
  comments: Comment[];
}
