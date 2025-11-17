import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { UserService } from '../../services/user.service';
import * as CryptoJS from 'crypto-js';

@Component({
  selector: 'app-register',
  templateUrl: './register.html',
  styleUrls: ['./register.css'],
  standalone: true,
  imports: [CommonModule, FormsModule],
})
export class Register {
  currentStep = 1;
  steps = Array(4).fill(0);
  emailExists = false; 

  constructor(
    private userService: UserService,
    private router: Router
  ) {}

  formData = {
    name: '',
    email: '',
    password: '' ,           
    confirmPassword: '',
    niveau: '',
    secteurs_pref: [] as string[],
    modele_eco_pref: '',
    budget_min: null,
    budget_max: null,
    taille_min: null,
    taille_max: null,
    seed_pref: [] as string[],
    valo_pre_min: null,
    valo_pre_max: null,
    valo_post_min: null,
    valo_post_max: null,
    location_city: '',
  location_lat: null as number | null,
  location_lon: null as number | null,
  
};


  availableSectors = ['Restauration', 'Santé et Pharmacie', 'Beauté', 'Transport'];
  seedStages = ['Seed', 'Série A', 'Série B', 'Série C'];
  modelesEconomiques = ['Marketplace', 'Abonnement', 'Freemium'];
  niveaux = ['Débutant', 'Intermédiaire', 'Avancé'];

  goNext() {
    if (this.currentStep < this.steps.length) {
      this.currentStep++;
    } else if (this.currentStep === this.steps.length) {
      this.submitForm();
    }
  }
  onCityBlur() {
  const city = this.formData.location_city?.trim();
  if (!city) return;

  const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(city)}`;

  fetch(url)
    .then(response => response.json())
    .then(data => {
      if (data.length > 0) {
        const location = data[0];
        this.formData.location_lat = parseFloat(location.lat);
        this.formData.location_lon = parseFloat(location.lon);
      } else {
        alert("Ville introuvable !");
        this.formData.location_lat = null;
        this.formData.location_lon = null;
      }
    })
    .catch(err => {
      console.error("Erreur géocodage :", err);
    });
}

  goBack() {
    if (this.currentStep > 1) this.currentStep--;
  }

  toggleSector(sector: string) {
    const index = this.formData.secteurs_pref.indexOf(sector);
    if (index >= 0) this.formData.secteurs_pref.splice(index, 1);
    else this.formData.secteurs_pref.push(sector);
  }

  toggleSeed(stage: string) {
    const index = this.formData.seed_pref.indexOf(stage);
    if (index >= 0) this.formData.seed_pref.splice(index, 1);
    else this.formData.seed_pref.push(stage);
  }

   submitForm() {
    this.emailExists = false; 
      if (this.formData.password !== this.formData.confirmPassword) {
    alert("Les mots de passe ne correspondent pas !");
    return;
  }
   const hashedPassword = CryptoJS.SHA256(this.formData.password).toString();
  this.formData.password = hashedPassword;
  this.formData.confirmPassword ='';


    this.userService.register(this.formData).subscribe({
      next: (res) => {
        const userId = res.user_id;
        localStorage.setItem('userId', userId);
        this.router.navigate(['/top5']);
      },
      error: (err) => {
        if (err.status === 409) {
          this.emailExists = true;
        } else {
          console.error('Erreur lors de l’enregistrement :', err);
        }
      }
    });
  }
}
