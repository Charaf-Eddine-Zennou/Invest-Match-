
import { Body, Controller, Get, NotFoundException, Param, Post, Put, UnauthorizedException } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto} from './dto/UpdateUser.dto'
import * as CryptoJS from 'crypto-js';

@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post('register')
  async register(@Body() userData: CreateUserDto) {
    return this.userService.createUser(userData);
    
  }

  @Put('update-profile')
async updateProfile(@Body() updateDto: UpdateUserDto) {
  return this.userService.updateProfile(updateDto);
}

  @Post('login')
async login(@Body() body: { email: string; password: string }) {
  const user = await this.userService.findByEmail(body.email);
  
  if (!user) {
    throw new NotFoundException('Utilisateur non trouvé');
  }

  const hashedPassword = CryptoJS.SHA256(body.password).toString();

  if (user.password !== hashedPassword) {
    throw new UnauthorizedException('Mot de passe incorrect');
  }

  return { user_id: user.user_id };
}

  @Get()
  async getAll() {
    return this.userService.getAll();
  }

  @Get('name/:name')
async getUserByName(@Param('name') name: string) {
  const user = await this.userService.findByName(name);
  if (!user) {
    throw new NotFoundException('Utilisateur non trouvé');
  }
  return user;
}
}
