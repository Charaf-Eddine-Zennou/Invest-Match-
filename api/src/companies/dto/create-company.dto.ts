import { IsUUID, IsString, IsNumber, IsInt, IsOptional, MaxLength, Min } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateCompanyDto {
  @IsString()
  @MaxLength(255)
  name: string;

  @IsString()
  @MaxLength(255)
  secteur: string;

  @IsNumber()
  @Min(0)
  @Type(() => Number)      
  montant: number;

  @IsInt()
  @Min(0)
  @Type(() => Number)
  taille: number;

  @IsString()
  @MaxLength(50)
  seed: string;

  @IsString()
  @MaxLength(100)
  modele_eco: string;

  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  valo_pre?: number;

  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  valo_post?: number;

  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  latitude?: number;

  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  longitude?: number;

  @IsString()
  company_email: string;

  @IsUUID()
  userId?: string;

  @IsOptional()
  @IsString()
  videoUrl?: string;
}
