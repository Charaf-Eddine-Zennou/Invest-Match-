import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CommentService {
  private baseUrl = 'http://localhost:3000/comments';

  constructor(private http: HttpClient) {}

  // Récupérer les commentaires
  getComments(companyId: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/company/${companyId}`);
  }

  // Ajouter un commentaire
  addComment(userId: string, companyId: string, content: string): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}/company/${companyId}`, { userId, content });
  }

  // Liker/unliker un commentaire
likeComment(commentId: string, userId: string) {
  return this.http.put<any>(
    `http://localhost:3000/comments/${commentId}/like/${userId}`, 
    {}
  );
}

}

