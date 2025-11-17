
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MatchService } from './match.service';
import { MatchController } from './match.controller';

import { Company } from '../entities/company.entity';
import { User } from '../entities/user.entity';
import { MatriceSecteurs } from '../entities/matrice-secteurs.entity';
import { TableauMontants } from '../entities/tableau-montants.entity';
import { TableauTailles } from '../entities/tableau_tailles.entity';
import { TableauSeed } from '../entities/tableau-seed.entity';
import { PoidsInitial } from '../entities/poids-initiaux.entity';
import { MatriceModelesEconomiques } from '../entities/matrice_modeles_economiques.entity';
import { TableauValorisation } from '../entities/tableau_valorisation.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Company,
      User,
      MatriceSecteurs,
      TableauMontants,
      TableauTailles,
      TableauSeed,
      PoidsInitial, 
      MatriceModelesEconomiques,
      TableauValorisation,
    ]),
  ],
  controllers: [MatchController],
  providers: [MatchService],
})
export class MatchModule {}
