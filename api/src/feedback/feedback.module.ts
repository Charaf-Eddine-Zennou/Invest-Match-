import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FeedbackHistory } from '../entities/feedback-history.entity';
import { FeedbackService } from './feedback.service';
import { FeedbackController } from './feedback.controller';

import { UserSectorPreference } from '../entities/user-sector-preference.entity';
import { UserSeedPreference } from '../entities/user-seed-preference.entity';
import { UserModelePreference } from '../entities/user-modele-preference.entity';
import { UserCustomWeight } from '../entities/user-custom-weight.entity';
import { UserCustomInterval } from '../entities/user-custom-interval.entity';
import { Company } from '../entities/company.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      FeedbackHistory,
      UserSectorPreference,
      UserSeedPreference,
      UserModelePreference,
      UserCustomWeight,
      UserCustomInterval,
      Company,
    ]),
  ],
  controllers: [FeedbackController],
  providers: [FeedbackService],
})
export class FeedbackModule {}
