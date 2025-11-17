import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './update-profile.html',
  styleUrls: ['./update-profile.css']
})
export class UpdateProfile {
  showEditForm = false;
  profileForm: FormGroup;

  constructor(private fb: FormBuilder, private http: HttpClient) {
    this.profileForm = this.fb.group({
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['']
    });
  }

  updateProfile() {
    if (this.profileForm.valid) {
      this.http.put('http://localhost:3000/users/update-profile', this.profileForm.value)
        .subscribe({
          next: () => {
            alert('Profil mis à jour avec succès !');
            this.showEditForm = false;
          },
          error: () => alert('Erreur lors de la mise à jour.')
        });
    }
  }
}
