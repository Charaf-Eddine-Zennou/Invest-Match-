import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'matrice_secteurs' })
export class MatriceSecteurs {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  secteur_source: string;

  @Column()
  secteur_cible: string;

  @Column({ type: 'float' })
  similarite: number;
}
