import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Company } from '../entities/company.entity';
import { CompaniesService } from './companies.service';
import { CompaniesController } from './companies.controller';
import { User } from 'src/entities/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Company, User])],
  providers: [CompaniesService],
  controllers: [CompaniesController],
  exports: [CompaniesService], 
})
export class CompaniesModule {}
