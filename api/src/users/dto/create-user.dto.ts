// src/users/dto/create-user.dto.ts
import {
  IsString,
  IsOptional,
  IsEnum,
  IsArray,
  IsEmail,
  IsNumber,
  IsUUID,
  MinLength,
} from 'class-validator';
import { Niveau } from '../../entities/user.entity';

export class CreateUserDto {
  @IsUUID()
  user_id: string;

  @IsString()
  name: string;

  @IsEmail()
  email: string;

   @IsString()
  @MinLength(6) 
  password: string

  @IsEnum(Niveau)
  niveau: Niveau;

  @IsOptional()
  @IsArray()
  secteurs_pref?: string[];

  @IsOptional()
  @IsString()
  modele_eco_pref?: string;

  @IsOptional()
  @IsNumber()
  budget_min?: number;

  @IsOptional()
  @IsNumber()
  budget_max?: number;

  @IsOptional()
  @IsNumber()
  taille_min?: number;

  @IsOptional()
  @IsNumber()
  taille_max?: number;

  @IsOptional()
  @IsArray()
  seed_pref?: string[];

  @IsOptional()
  @IsNumber()
  valo_pre_min?: number;

  @IsOptional()
  @IsNumber()
  valo_pre_max?: number;

  @IsOptional()
  @IsNumber()
  valo_post_min?: number;

  @IsOptional()
  @IsNumber()
  valo_post_max?: number;

  @IsOptional()
  @IsString()
  location_city?: string;

  @IsOptional()
  @IsNumber()
  location_lat?: number;

  @IsOptional()
  @IsNumber()
  location_lon?: number;
}
