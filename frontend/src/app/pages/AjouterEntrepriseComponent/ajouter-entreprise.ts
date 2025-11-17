import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Location } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-ajouter-entreprise',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './ajouter-entreprise.html',
  styleUrls: ['./ajouter-entreprise.css'],
})
export class AjouterEntrepriseComponent {
  entreprise: {
  name: string;
  secteur: string;
  montant: number | null;
  taille: number | null;
  seed: string;
  modele_eco: string;
  valo_pre: number | null;
  valo_post: number | null;
  company_email: string;
  ville: string;
  latitude: number | null;
  longitude: number | null;
  video: File | null;
} = {
  name: '',
  secteur: '',
  montant: null,
  taille: null,
  seed: '',
  modele_eco: '',
  valo_pre: null,
  valo_post: null,
  company_email: '',
  ville: '',
  latitude: null,
  longitude: null,
  video: null
};


  constructor(private http: HttpClient,private location: Location) {}
   retour() {
    this.location.back();
  }

    onVilleBlur() {
    if (!this.entreprise.ville || this.entreprise.ville.trim() === '') {
      return;
    }

    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(this.entreprise.ville)}`;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        if (data.length > 0) {
          const location = data[0];
          this.entreprise.latitude = location.lat;
          this.entreprise.longitude = location.lon;
        } else {
          alert("Ville introuvable !");
          this.entreprise.latitude = null;
          this.entreprise.longitude = null;
        }
      })
      .catch(err => {
        console.error("Erreur géocodage :", err);
      });
  }

  onFileSelected(event: any) {
    const file = event.target.files[0];
    if (file) {
      this.entreprise.video = file;
    }
  }
ajouterEntreprise() {
  const formData = new FormData();

  // On convertit explicitement les nombres en string pour FormData
  formData.append('name', this.entreprise.name || '');
  formData.append('secteur', this.entreprise.secteur || '');
  formData.append('montant', this.entreprise.montant != null ? this.entreprise.montant.toString() : '');
  formData.append('taille', this.entreprise.taille != null ? this.entreprise.taille.toString() : '');
  formData.append('seed', this.entreprise.seed || '');
  formData.append('modele_eco', this.entreprise.modele_eco || '');
  formData.append('valo_pre', this.entreprise.valo_pre != null ? this.entreprise.valo_pre.toString() : '');
  formData.append('valo_post', this.entreprise.valo_post != null ? this.entreprise.valo_post.toString() : '');
  formData.append('company_email', this.entreprise.company_email || '');
  formData.append('latitude', this.entreprise.latitude != null ? this.entreprise.latitude.toString() : '');
  formData.append('longitude', this.entreprise.longitude != null ? this.entreprise.longitude.toString() : '');
  formData.append('userId', localStorage.getItem('userId') || '');

  // Vidéo
  if (this.entreprise.video) {
    formData.append('video', this.entreprise.video, this.entreprise.video.name);
  }

  // Affiche toutes les données envoyées
  for (const [key, value] of formData.entries()) {
    console.log(key, value);
  }

  // POST
  this.http.post('http://localhost:3000/companies', formData)
    .subscribe({
      next: () => alert('Entreprise ajoutée avec succès'),
      error: (err) => alert('Erreur lors de l’ajout : ' + err.message)
    });
}



}
