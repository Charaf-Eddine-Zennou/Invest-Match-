import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';


@Injectable({ providedIn: 'root' })
export class MatchService {
  private apiUrl = 'http://localhost:3000/match';

  constructor(private http: HttpClient) {}

  getTop5Entreprises(userId: string): Observable<any[]> {
  return this.http.get<any[]>(`${this.apiUrl}/top5/${userId}`);
}

}
