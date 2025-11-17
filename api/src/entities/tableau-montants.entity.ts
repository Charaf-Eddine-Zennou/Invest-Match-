import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('tableau_montants')
export class TableauMontants {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  niveau: string;

  @Column({ type: 'int' })
  montant_min: number;

  @Column({ type: 'int' })
  montant_max: number;
}
