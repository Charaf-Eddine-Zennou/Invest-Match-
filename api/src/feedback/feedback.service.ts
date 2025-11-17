
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { FeedbackHistory } from '../entities/feedback-history.entity';
import { CreateFeedbackDto } from './dto/create-feedback.dto';
import { UserSectorPreference } from '../entities/user-sector-preference.entity';
import { UserSeedPreference } from '../entities/user-seed-preference.entity';
import { UserModelePreference } from '../entities/user-modele-preference.entity';
import { UserCustomWeight } from '../entities/user-custom-weight.entity';
import { UserCustomInterval } from '../entities/user-custom-interval.entity';
import { Company } from '../entities/company.entity';

@Injectable()
export class FeedbackService {
  constructor(
    @InjectRepository(FeedbackHistory)
    private readonly feedbackRepo: Repository<FeedbackHistory>,

    @InjectRepository(UserSectorPreference)
    private readonly sectorRepo: Repository<UserSectorPreference>,

    @InjectRepository(UserSeedPreference)
    private readonly seedRepo: Repository<UserSeedPreference>,

    @InjectRepository(UserModelePreference)
    private readonly modeleRepo: Repository<UserModelePreference>,

    @InjectRepository(UserCustomWeight)
    private readonly weightRepo: Repository<UserCustomWeight>,

    @InjectRepository(UserCustomInterval)
    private readonly intervalRepo: Repository<UserCustomInterval>,

    @InjectRepository(Company)
    private readonly companyRepo: Repository<Company>,
  ) {}

  async handleFeedback(dto: CreateFeedbackDto): Promise<string | void> {
    // Vérifier unicité
    const exists = await this.feedbackRepo.findOne({ where: { user_id: dto.user_id, company_id: dto.company_id } });
    if (exists) return 'exists';

    const company = await this.companyRepo.findOne({ where: { company_id: dto.company_id } });
    if (!company) return;

    const isLike = dto.feedback === 'like';
    
    await this.updatePreference(this.sectorRepo, dto.user_id, company.secteur, 'secteur', isLike);
    await this.updatePreference(this.seedRepo, dto.user_id, company.seed, 'seed', isLike);
    await this.updatePreference(this.modeleRepo, dto.user_id, company.modele_eco, 'modele_eco', isLike);

    await this.updateInterval(dto.user_id, 'montant', company.montant);
    await this.updateInterval(dto.user_id, 'taille', company.taille);
    if (company.valo_pre) await this.updateInterval(dto.user_id, 'valorisation_pre', company.valo_pre);
    if (company.valo_post) await this.updateInterval(dto.user_id, 'valorisation_post', company.valo_post);

    await this.feedbackRepo.save(this.feedbackRepo.create(dto));
  }

  private async updatePreference(
    repo: Repository<any>,
    user_id: string,
    value: string,
    critere: string,
    isLike: boolean,
  ) {
    let pref = await repo.findOne({ where: { user_id, [critere]: value } });
    if (!pref) {
      pref = repo.create({
        user_id,
        [critere]: value,
        score: 0,
        likes_count: 0,
        dislikes_count: 0,
      });
    }

    if (isLike) pref.likes_count += 1;
    else pref.dislikes_count += 1;

    const n = isLike ? pref.likes_count : pref.dislikes_count;
    const modif = this.roundTo0_0005(0.0025 * Math.pow(n, critere === 'secteur' ? 1.5 : 1.3));
    pref.score += isLike ? modif : -modif;

    await repo.save(pref);

    
    const log_part = this.roundTo0_0005(Math.log2(n + 1) + n / 4);
    const increment = log_part * (critere === 'secteur' ? 0.0025 : 0.00125);

    let weight = await this.weightRepo.findOne({ where: { user_id, critere } });
    if (!weight) {
      weight = this.weightRepo.create({ user_id, critere, poids_personnalise: 0 });
    }

    weight.poids_personnalise = Math.min(1, weight.poids_personnalise + increment);
    await this.weightRepo.save(weight);
  }

  private async updateInterval(user_id: string, critere: string, valeur: number) {
    let interval = await this.intervalRepo.findOne({ where: { user_id, critere } });
    if (!interval) {
      interval = this.intervalRepo.create({
        user_id,
        critere,
        borne_min: valeur,
        borne_max: valeur,
      });
    }

    const mid = interval.borne_min + (interval.borne_max - interval.borne_min) / 2;

    if (valeur > mid) interval.borne_max += Math.abs(valeur - mid) * 0.2;
    else interval.borne_min = Math.max(0, interval.borne_min - Math.abs(mid - valeur) * 0.2);

    await this.intervalRepo.save(interval);
  }

  private roundTo0_0005(val: number): number {
    return Math.round(val * 2000) / 2000;
  }
}
