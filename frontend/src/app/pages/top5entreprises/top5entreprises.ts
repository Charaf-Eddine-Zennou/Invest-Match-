import { Component, OnInit, ViewChild, ElementRef, ViewChildren, QueryList} from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatchService } from '../../services/match.service';
import { LucideAngularModule } from 'lucide-angular';
import { FeedbackService } from '../../services/feedback.service';
import { CommentService } from '../../services/comment.service';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { UserService } from '../../services/user.service';

export enum TabEnum {
  Top5 = 'top5',
  Profil = 'profil',
  Investissements = 'investissements',
  Messages = 'messages'
}

@Component({
  selector: 'app-top5entreprises',
  standalone: true,
  imports: [CommonModule, LucideAngularModule, FormsModule],
  templateUrl: './top5entreprises.html',
  styleUrls: ['./top5entreprises.css'],
})
export class Top5EntreprisesComponent implements OnInit {
  entreprises: any[] = [];
  filteredEntreprises: any[] = [];
  userId: string ='';
  authUser: any = null;
  selectedCompany: any = null;
  profilSection: string = 'investissements';
  searchTerm: string = '';
  activeTab: TabEnum = TabEnum.Top5;
  TabEnum = TabEnum;  
  comments: any[] = [];
  newComment: string = '';
  messages: any[] = [];

  constructor(
    private userService: UserService,
    private matchService: MatchService,
    private feedbackService: FeedbackService,
    private commentService: CommentService,
    private router: Router,
    private http: HttpClient
  ) {}

    user: any = null;  

    ngOnInit(): void {
  const storedUser = localStorage.getItem('user');

  if (storedUser) {
    try {
      this.user = JSON.parse(storedUser);

      // Récupérer l'ID utilisateur
      const uid = this.user?.user_id ?? this.user?.id;

      if (!uid) {
        console.warn(' Aucun user_id/id trouvé.');
        this.router.navigate(['/login']);
        return;
      }

      // On est sûr que uid existe, donc on peut l'assigner en string
      this.userId = uid.toString();
      localStorage.setItem('userId', this.userId);

      // Créer un objet authUser complet
      this.authUser = { ...this.user, id: this.userId };
      

      // Charger le top 5 entreprises
      this.matchService.getTop5Entreprises(this.userId).subscribe({
        next: (data: any[]) => {
           console.log('📦 Entreprises API:', data); 
          this.entreprises = data.map(e => ({
            ...e,
            videoUrl: e.videoUrl,
            liked: false,
            disliked: false,
            saved: false
          }));
          this.filteredEntreprises = [...this.entreprises];
        },
        error: (err) => console.error('Erreur récupération entreprises :', err)
      });

      this.userService.getConversations(this.userId).subscribe({
  next: (res: any[]) => {
    this.messages = res.map(u => ({
      user_id: u.user_id,
      name: u.name || 'Utilisateur inconnu',
      email: u.email || ''
    }));
  },
  error: (err) => {
    console.error('Erreur récupération conversations :', err);
    this.messages = [];
  }
});

    } catch (err) {
      console.error('Erreur parsing localStorage user :', err);
      this.router.navigate(['/login']);
    }

  } else {
    console.warn(' Aucun utilisateur authentifié.');
    this.router.navigate(['/login']);
  }
}





  // Charger utilisateur depuis localStorage
  loadCurrentUser() {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      this.authUser = JSON.parse(storedUser);
      this.userId = this.authUser.user_id;
    }
  }

  searchEntreprises() {
    if (!this.searchTerm.trim()) {
      this.filteredEntreprises = [...this.entreprises];
      return;
    }

    this.searchEntreprisesApi(this.searchTerm).subscribe(
      (data: any[]) => {
        this.filteredEntreprises = data.map(e => ({
          ...e,
          nom: e.name,
          videoUrl: e.videoUrl,
          liked: false,
          disliked: false,
          saved: false
        }));
      },
      (error) => console.error('Erreur recherche entreprise :', error)
    );
  }

  private searchEntreprisesApi(name: string): Observable<any[]> {
    return this.http.get<any[]>(`http://localhost:3000/companies/search?name=${encodeURIComponent(name)}`);
  }

  like(entreprise: any) {
    entreprise.liked = !entreprise.liked;
    if (entreprise.liked) entreprise.disliked = false;
    if (!this.userId) return;

    this.feedbackService.sendFeedback(this.userId, entreprise.entreprise_id, 'like')
      .subscribe({
        next: () => {},
        error: err => console.error('Erreur feedback like', err)
      });
  }

  dislike(entreprise: any) {
    entreprise.disliked = !entreprise.disliked;
    if (entreprise.disliked) entreprise.liked = false;
    if (!this.userId) return;

    this.feedbackService.sendFeedback(this.userId, entreprise.entreprise_id, 'dislike')
      .subscribe({
        next: () => {},
        error: err => console.error('Erreur feedback dislike', err)
      });
  }

  save(entreprise: any) {
    entreprise.saved = !entreprise.saved;
  }

  

    setTab(tab: TabEnum) {
    this.activeTab = tab;
  }



  modifierProfil() {
    this.router.navigate(['/update-profile']);
  }

  setProfilSection(section: string) {
    this.profilSection = section;
  }

  openComments(entreprise: any) {
  this.selectedCompany = entreprise;
  if (!entreprise?.entreprise_id) return;

  this.commentService.getComments(entreprise.entreprise_id).subscribe(data => {
    this.comments = data.map(c => ({
      ...c,
      likedByCurrentUser: false,
      likeCount: c.likeCount
    }));
  });
}

  addComment() {
    if (!this.authUser || !this.selectedCompany) return;

    this.commentService.addComment(
      this.authUser.user_id,
      this.selectedCompany.entreprise_id,
      this.newComment
    ).subscribe(c => {
      this.comments.unshift({ ...c, likedByCurrentUser: false });
      this.newComment = '';
    }, err => console.error('Erreur addComment', err));
  }

  likeComment(comment: any) {
  if (!this.authUser) return;

  this.commentService.likeComment(comment.id, this.authUser.user_id).subscribe(res => {
    comment.likeCount = res.likes;
    comment.likedByCurrentUser = res.likedByCurrentUser;
  });
}

showNotifications = false;

toggleNotifications() {
  this.showNotifications = !this.showNotifications;
}  

searchQuery: string = '';
searchResults: any[] = [];



    searchUsers() {
  if (!this.searchQuery.trim()) {
    this.searchResults = [];
    return;
  }

  this.userService.searchUserByName(this.searchQuery).subscribe({
    next: (user) => {
      this.searchResults = user ? [{
        user_id: user.user_id,
        name: user.name || 'Utilisateur inconnu',
        email: user.email || ''
      }] : [];
    },
    error: () => {
      this.searchResults = [];
    }
  });
}


goToMessages(user: any) {
  this.router.navigate(['/messages', user.user_id]);
}

goToAjouterEntreprise() {
  this.router.navigate(['/ajouter-entreprise']);
}


@ViewChildren('videoElement') videoElements!: QueryList<ElementRef<HTMLVideoElement>>;

ngAfterViewInit(): void {
  this.videoElements.changes.subscribe(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          const video = entry.target as HTMLVideoElement;
          if (entry.isIntersecting) {
            video.play();
          } else {
            video.pause();
          }
        });
      },
      { threshold: 0.6 }
    );

    this.videoElements.forEach(videoRef => {
      observer.observe(videoRef.nativeElement);
    });
  });
}
  
}
