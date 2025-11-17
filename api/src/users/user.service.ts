
import { Injectable, ConflictException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { CreateUserDto } from './dto/create-user.dto';
import * as CryptoJS from 'crypto-js';
import { UpdateUserDto } from './dto/UpdateUser.dto';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly usersRepository: Repository<User>,
  ) {}

  async createUser(data: CreateUserDto): Promise<User> {
    const existing = await this.usersRepository.findOne({ where: { email: data.email } });
    if (existing) {
      throw new ConflictException('Email already exists');
    }
    return this.usersRepository.save(data);
  }

  async findByEmail(email: string): Promise<User | null> {
  return this.usersRepository.findOne({ where: { email } });
}

async updateProfile(updateDto: UpdateUserDto): Promise<User> {
  const user = await this.usersRepository.findOne({ where: { user_id: updateDto.user_id } });
  if (!user) throw new NotFoundException('Utilisateur non trouvé');

  user.name = updateDto.name;
  user.email = updateDto.email;

  if (updateDto.password) {
       user.password = CryptoJS.SHA256(updateDto.password).toString();
  }

  return this.usersRepository.save(user);
}


  async getAll(): Promise<User[]> {
    return this.usersRepository.find();
  }

  async findByName(name: string) {
  return await this.usersRepository.findOne({ where: { name } });
}

  

  async getUserByEmail(email: string): Promise<User | undefined> {
    return this.usersRepository.findOne({ where: { email } });
  }
}
