import { 
  Controller, Get, Post, Patch, Delete, Param, Body, Query, 
  ParseUUIDPipe, BadRequestException, UseInterceptors, UploadedFile, 
  Res, Req 
} from '@nestjs/common';
import { CompaniesService } from './companies.service';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import type { Request, Response } from 'express';

import { join } from 'path';
import * as fs from 'fs';

@Controller('companies')
export class CompaniesController {
  constructor(private readonly companiesService: CompaniesService) {}

@Post()
@UseInterceptors(FileInterceptor('video', {
  storage: diskStorage({
    destination: './uploads/videos',
    filename: (req, file, callback) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      callback(null, uniqueSuffix + '-' + file.originalname);
    }
  })
}))
async create(
  @UploadedFile() file: Express.Multer.File,
  @Body() dto: CreateCompanyDto
) {
  // Conversion des strings du FormData en nombres
  dto.montant = Number(dto.montant);
  dto.taille = Number(dto.taille);
  if (dto.valo_pre !== undefined && dto.valo_pre !== null) dto.valo_pre = Number(dto.valo_pre);
  if (dto.valo_post !== undefined && dto.valo_post !== null) dto.valo_post = Number(dto.valo_post);

  const videoUrl = file ? '/companies/video/' + file.filename : null;
  return this.companiesService.create(dto, dto.userId, videoUrl);
}


  @Get('search')
  async search(@Query('name') name: string) {
    console.log('Received search name:', name); 
    if (!name || !name.trim()) {
      throw new BadRequestException('Le paramètre name est obligatoire.');
    }
    return this.companiesService.searchByName(name.trim());
  }

  @Get('filter/search')
  filter(
    @Query('secteur') secteur?: string,
    @Query('seed') seed?: string,
    @Query('modele_eco') modele_eco?: string,
    @Query('montantMin') montantMin?: string,
    @Query('montantMax') montantMax?: string,
    @Query('tailleMin') tailleMin?: string,
    @Query('tailleMax') tailleMax?: string,
    @Query('valoPreMin') valoPreMin?: string,
    @Query('valoPreMax') valoPreMax?: string,
    @Query('valoPostMin') valoPostMin?: string,
    @Query('valoPostMax') valoPostMax?: string,
    @Query('search') search?: string,
    @Query('videoUrl') videoUrl?: string,
  ) {
    return this.companiesService.findWithFilters({
      filters: {
        secteur,
        seed,
        modele_eco,
        montantMin: montantMin ? Number(montantMin) : undefined,
        montantMax: montantMax ? Number(montantMax) : undefined,
        tailleMin: tailleMin ? Number(tailleMin) : undefined,
        tailleMax: tailleMax ? Number(tailleMax) : undefined,
        valoPreMin: valoPreMin ? Number(valoPreMin) : undefined,
        valoPreMax: valoPreMax ? Number(valoPreMax) : undefined,
        valoPostMin: valoPostMin ? Number(valoPostMin) : undefined,
        valoPostMax: valoPostMax ? Number(valoPostMax) : undefined,
        search,
        videoUrl,
      }
    });
  }

  @Get()
  findAll() {
    return this.companiesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id', new ParseUUIDPipe()) id: string) {
    return this.companiesService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', new ParseUUIDPipe()) id: string,
    @Body() dto: UpdateCompanyDto,
  ) {
    return this.companiesService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id', new ParseUUIDPipe()) id: string) {
    return this.companiesService.remove(id);
  }


  
  


}

