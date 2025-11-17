import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import {
  Repository,
  FindOptionsWhere,
  ILike,
  Like,
} from 'typeorm';
import { Company } from '../entities/company.entity';
import { User } from '../entities/user.entity';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';

@Injectable()
export class CompaniesService {
  constructor(
    @InjectRepository(Company)
    private readonly repo: Repository<Company>,
    
    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
  ) {}

  async create(dto: CreateCompanyDto, userId: string, videoUrl?: string): Promise<Company> {
    const existing = await this.repo.findOne({ where: { company_email: dto.company_email } });
    if (existing) throw new BadRequestException('Une entreprise avec cet email existe déjà.');

    const user = await this.userRepo.findOne({ where: { user_id: userId } });
    if (!user) throw new NotFoundException('Utilisateur non trouvé');

    const entity = this.repo.create({
      ...dto,
      company_email: dto.company_email,
      videoUrl,
      creator: user
    });

    return this.repo.save(entity);
  }

  async findAll(): Promise<Company[]> {
    return this.repo.find();
  }

  async findOne(company_id: string): Promise<Company> {
    const company = await this.repo.findOne({ where: { company_id } });
    if (!company) throw new NotFoundException(`Company ${company_id} not found`);
    return company;
  }

  async searchByName(name: string): Promise<Company[]> {
  return this.repo.find({
    where: { name: Like(`%${name}%`) },
  });
}

  async update(company_id: string, dto: UpdateCompanyDto): Promise<Company> {
    const company = await this.findOne(company_id);
    Object.assign(company, dto);
    return this.repo.save(company);
  }

  async remove(company_id: string): Promise<void> {
    await this.repo.delete({ company_id });
  }

  async findWithFilters({ filters }: {
  filters: {
    secteur?: string;
    seed?: string;
    modele_eco?: string;
    montantMin?: number;
    montantMax?: number;
    tailleMin?: number;
    tailleMax?: number;
    valoPreMin?: number;
    valoPreMax?: number;
    valoPostMin?: number;
    valoPostMax?: number;
    search?: string;
    videoUrl?: string;
  };
}): Promise<Company[]> {
    const where: FindOptionsWhere<Company> = {};

    if (filters.secteur) where.secteur = filters.secteur;
    if (filters.seed) where.seed = filters.seed;
    if (filters.modele_eco) where.modele_eco = filters.modele_eco;
    if (filters.videoUrl) where.videoUrl = filters.videoUrl;

    const qb = this.repo.createQueryBuilder('c').where(where);

    if (filters.search) {
      qb.andWhere({ name: ILike(`%${filters.search}%`) });
    }

    if (filters.montantMin !== undefined) qb.andWhere('c.montant >= :montantMin', { montantMin: filters.montantMin });
    if (filters.montantMax !== undefined) qb.andWhere('c.montant <= :montantMax', { montantMax: filters.montantMax });

    if (filters.tailleMin !== undefined) qb.andWhere('c.taille >= :tailleMin', { tailleMin: filters.tailleMin });
    if (filters.tailleMax !== undefined) qb.andWhere('c.taille <= :tailleMax', { tailleMax: filters.tailleMax });

    if (filters.valoPreMin !== undefined) qb.andWhere('c.valo_pre >= :valoPreMin', { valoPreMin: filters.valoPreMin });
    if (filters.valoPreMax !== undefined) qb.andWhere('c.valo_pre <= :valoPreMax', { valoPreMax: filters.valoPreMax });

    if (filters.valoPostMin !== undefined) qb.andWhere('c.valo_post >= :valoPostMin', { valoPostMin: filters.valoPostMin });
    if (filters.valoPostMax !== undefined) qb.andWhere('c.valo_post <= :valoPostMax', { valoPostMax: filters.valoPostMax });
    

    return qb.getMany();
  }
}
