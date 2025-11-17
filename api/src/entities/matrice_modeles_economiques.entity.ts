import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'matrice_modeles_economiques' })
export class MatriceModelesEconomiques {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  modele_source: string;

  @Column()
  modele_cible: string;

  @Column({ type: 'float' })
  similarite: number;
}
