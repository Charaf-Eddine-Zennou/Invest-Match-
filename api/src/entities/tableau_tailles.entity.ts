
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('tableau_tailles')
export class TableauTailles {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  niveau: string;

  @Column()
  taille_min: number;

  @Column()
  taille_max: number;
}
