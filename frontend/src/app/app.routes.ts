import { Routes } from '@angular/router';
import { WelcomeComponent } from './pages/welcome/welcome';
import { Register } from './pages/register/register';
import { Top5EntreprisesComponent } from './pages/top5entreprises/top5entreprises'; 
import { AjouterEntrepriseComponent } from './pages/AjouterEntrepriseComponent/ajouter-entreprise'; 
import { LoginComponent } from './pages/LoginComponent/login';
import { UpdateProfile } from './pages/update-profile/update-profile';
import { MessagesComponent } from './pages/messages/messages';


export const routes: Routes = [
  {
    path: '',
    component: WelcomeComponent
  },
  { path: 'login', component: LoginComponent },
   { path: 'ajouter-entreprise', component: AjouterEntrepriseComponent },
   { path: 'messages/:id', component: MessagesComponent },
    {
    path: 'register',
    component: Register
  },
   { path: 'top5', component: Top5EntreprisesComponent },
   { path :'update-profile', component: UpdateProfile}
];
