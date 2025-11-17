
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'tableau_valorisation' })
export class TableauValorisation {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  type: string; 

  @Column('float')
  valo_min: number;

  @Column('float')
  valo_max: number;

  @Column('float')
  poids: number;
}
