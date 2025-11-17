import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  standalone: true,
  templateUrl: './login.html',
  styleUrls: ['./login.css'],
    imports: [CommonModule, FormsModule, RouterModule, HttpClientModule],
})
export class LoginComponent {
  user = {
  email: '',
  password: ''
};


  erreurMessage: string | null = null;

  constructor(private http: HttpClient, private router: Router) {}

  seConnecter() {
    this.http.post<any>('http://localhost:3000/users/login', this.user).subscribe({
      next: (response) => {
        if (response && response.user_id) {
          localStorage.setItem('userId', response.user_id);
          localStorage.setItem('user', JSON.stringify(response)); 
          this.router.navigate(['/top5']);
        } else {
          this.erreurMessage = 'Utilisateur non trouvé';
        }
      },
      error: (err) => {
        this.erreurMessage = 'Erreur lors de la connexion : ' + err.message;
      }
      
    });
  }
}
