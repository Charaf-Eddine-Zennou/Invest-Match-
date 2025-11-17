// src/match/match.controller.ts
import { Controller, Get, Param, NotFoundException } from '@nestjs/common';
import { MatchService } from './match.service';

@Controller('match')
export class MatchController {
  constructor(private readonly matchService: MatchService) {}

  @Get('top5/:userId')
  async getTop5Matches(@Param('userId') userId: string) {
    const results = await this.matchService.getTop5Matches(userId);

    if (!results || results.length === 0) {
      throw new NotFoundException(`Aucune entreprise trouvée pour l'utilisateur ${userId}`);
    }

    return results;
  }
}
