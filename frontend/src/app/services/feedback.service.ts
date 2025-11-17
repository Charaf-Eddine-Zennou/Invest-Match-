// src/app/services/feedback.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export type FeedbackType = 'like' | 'dislike';

@Injectable({
  providedIn: 'root'
})
export class FeedbackService {
  private apiUrl = 'http://localhost:3000/api/feedback';

  constructor(private http: HttpClient) {}

  sendFeedback(user_id: string, company_id: string, feedback: FeedbackType): Observable<any> {
    return this.http.post(this.apiUrl, { user_id, company_id, feedback });
  }
}
