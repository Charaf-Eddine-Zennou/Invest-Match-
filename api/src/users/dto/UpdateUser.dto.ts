import { IsEmail, IsOptional, IsString, MinLength, IsUUID } from 'class-validator';

export class UpdateUserDto {
  @IsUUID()
  user_id: string;

  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsEmail({}, { message: 'Email invalide' })
  email?: string;

  @IsOptional()
  @IsString()
  password?: string;
}
