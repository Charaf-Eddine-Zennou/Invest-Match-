import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private apiUrl = 'http://localhost:3000/users/register';
  private apiUrl1 = 'http://localhost:3000/users';

  constructor(private http: HttpClient) {}

  register(userData: any): Observable<any> {
    return this.http.post(this.apiUrl, userData);
  }

   searchUserByName(name: string): Observable<any> {
    return this.http.get(`${this.apiUrl1}/name/${name}`);
  }

  getConversations(userId: string) {
  return this.http.get<any[]>(`http://localhost:3000/messages/conversations?userId=${userId}`);
}
}
