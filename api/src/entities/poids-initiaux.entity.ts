
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'poids_initiaux' })
export class PoidsInitial {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  niveau: string;

  @Column('float')
  poids_secteur: number;

  @Column('float')
  poids_prix: number;

  @Column('float')
  poids_taille: number;

  @Column('float')
  poids_seed: number;

  @Column('float')
  poids_modele: number;

  @Column('float')
  poids_valo_pre: number;

  @Column('float')
  poids_valo_post: number;
}
