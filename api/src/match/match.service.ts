import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Company } from '../entities/company.entity';
import { User } from '../entities/user.entity';
import { MatriceSecteurs } from '../entities/matrice-secteurs.entity';
import { TableauMontants } from '../entities/tableau-montants.entity';
import { TableauTailles } from '../entities/tableau_tailles.entity';
import { TableauSeed } from '../entities/tableau-seed.entity';
import { PoidsInitial } from '../entities/poids-initiaux.entity';
import { MatriceModelesEconomiques } from '../entities/matrice_modeles_economiques.entity';
import { TableauValorisation } from '../entities/tableau_valorisation.entity';

@Injectable()
export class MatchService {
  constructor(
    @InjectRepository(Company)
    private readonly companyRepo: Repository<Company>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,

    @InjectRepository(MatriceSecteurs)
    private readonly matriceSecteurRepo: Repository<MatriceSecteurs>,

    @InjectRepository(TableauMontants)
    private readonly montantRepo: Repository<TableauMontants>,

    @InjectRepository(TableauTailles)
    private readonly tailleRepo: Repository<TableauTailles>,

    @InjectRepository(TableauSeed)
    private readonly seedRepo: Repository<TableauSeed>,

    @InjectRepository(PoidsInitial)
    private readonly poidsRepo: Repository<PoidsInitial>,

    @InjectRepository(MatriceModelesEconomiques)
    private readonly matriceModelesRepo: Repository<MatriceModelesEconomiques>,

    @InjectRepository(TableauValorisation)
    private readonly valoRepo: Repository<TableauValorisation>
  ) {}

  async getTop5Matches(userId: string) {
    const user = await this.userRepo.findOne({ where: { user_id: userId } });
    if (!user) throw new Error('Utilisateur non trouvé');

    const companies = await this.companyRepo.find();
    const seedData = await this.seedRepo.find();
    const montantData = await this.montantRepo.find();
    const secteurMatrix = await this.matriceSecteurRepo.find();
    const modeleMatrix = await this.matriceModelesRepo.find();
    const valoPreList = await this.valoRepo.find({ where: { type: 'pre' } });
    const valoPostList = await this.valoRepo.find({ where: { type: 'post' } });

    const poidsData = await this.poidsRepo.findOne({ where: { niveau: user.niveau } });
    if (!poidsData) throw new Error('Poids non trouvé pour ce niveau');

    const poids = {
      secteur: poidsData.poids_secteur,
      prix: poidsData.poids_prix,
      taille: poidsData.poids_taille,
      seed: poidsData.poids_seed,
      modele: poidsData.poids_modele,
      valo_pre: poidsData.poids_valo_pre,
      valo_post: poidsData.poids_valo_post,
    };

    const userSecteurs = Array.isArray(user.secteurs_pref) ? user.secteurs_pref : JSON.parse(user.secteurs_pref || '[]');
    
    let userModeles = [];

try {
  userModeles = JSON.parse(user.modele_eco_pref);
} catch (e) {
  userModeles = [user.modele_eco_pref]; 
}
    const niveau = user.niveau;

    const results = [];

    for (const company of companies) {
      let score_total = 0;

      // Secteur
      let secteurScore = 0;
      if (userSecteurs.includes(company.secteur)) {
        secteurScore = 1;
      } else {
        const sim = secteurMatrix.filter(s => s.secteur_source === company.secteur && userSecteurs.includes(s.secteur_cible));
        if (sim.length > 0) secteurScore = Math.max(...sim.map(s => s.similarite));
      }
      score_total += poids.secteur * secteurScore;

      // Prix
      const range = montantData.find(r => r.niveau === niveau);
      let scorePrix = 0;
      if (range && company.montant >= range.montant_min && company.montant <= range.montant_max) {
        scorePrix = 1;
      } else if (range) {
        const ecart = company.montant < range.montant_min ? range.montant_min - company.montant : company.montant - range.montant_max;
        scorePrix = Math.max(0, 1 - 0.1 * (ecart / 50000));
      }
      score_total += poids.prix * scorePrix;

      // Taille
      const tailleCible = 50;
      const ecartTaille = Math.abs(company.taille - tailleCible);
      let scoreTaille = 1;
      if (ecartTaille > 10) scoreTaille = Math.max(0, 1 - 0.15 * (ecartTaille / 20));
      score_total += poids.taille * scoreTaille;

      // Seed
      const seedScore = seedData.find(s => s.niveau === niveau && s.seed === company.seed)?.poids || 0;
      score_total += poids.seed * seedScore;

      // Modèle économique
      let modeleScore = 0;
      if (userModeles.includes(company.modele_eco)) {
        modeleScore = 1;
      } else {
        const sims = modeleMatrix.filter(
          m => m.modele_source === company.modele_eco && userModeles.includes(m.modele_cible)
        );
        if (sims.length > 0) modeleScore = Math.max(...sims.map(m => m.similarite));
      }
      score_total += poids.modele * modeleScore;

      // Valorisation pré
      const valoPre = valoPreList.find(v => company.valo_pre >= v.valo_min && company.valo_pre <= v.valo_max);
      const scoreValoPre = valoPre ? valoPre.poids : 0;
      score_total += poids.valo_pre * scoreValoPre;

      // Valorisation post
      const valoPost = valoPostList.find(v => company.valo_post >= v.valo_min && company.valo_post <= v.valo_max);
      const scoreValoPost = valoPost ? valoPost.poids : 0;
      score_total += poids.valo_post * scoreValoPost;

      results.push({
        entreprise_id: company.company_id,
        nom: company.name,
        score: parseFloat(score_total.toFixed(4)),
        secteur: company.secteur,
        prix: company.montant,
        taille: company.taille,
        localisation: {
          lat: company.latitude,
          lng: company.longitude,
        },
        seed: company.seed,
        modele_eco: company.modele_eco,
        valo_pre: company.valo_pre,
        valo_post: company.valo_post,
        videoUrl: company.videoUrl,
      });
    }

    return results.sort((a, b) => b.score - a.score).slice(0, 5);
  }
}
