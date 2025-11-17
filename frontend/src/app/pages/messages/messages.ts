import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-messages',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './messages.html',
  styleUrls: ['./messages.css']
})
export class MessagesComponent implements OnInit {
  userId!: string;           // user sélectionné
  currentUserId!: string;    // utilisateur connecté
  messages: any[] = [];
  newMessage = '';

  constructor(private route: ActivatedRoute, private http: HttpClient) {}

  ngOnInit(): void {
    this.currentUserId = localStorage.getItem('userId')!;
    this.userId = this.route.snapshot.paramMap.get('id')!;

    if (!this.currentUserId || !this.userId) {
      console.error('IDs utilisateur manquants');
      return;
    }

    this.loadMessages();
  }

  loadMessages() {
    this.http.get<any[]>(`http://localhost:3000/messages?senderId=${this.currentUserId}&receiverId=${this.userId}`)
      .subscribe({
        next: data => this.messages = data,
        error: err => console.error('Erreur chargement messages :', err)
      });
  }

  sendMessage() {
    if (!this.newMessage.trim()) return;

    this.http.post(`http://localhost:3000/messages`, {
      content: this.newMessage,
      senderId: this.currentUserId,
      receiverId: this.userId
    }).subscribe({
      next: msg => {
        this.messages.push(msg);
        this.newMessage = '';
      },
      error: err => console.error('Erreur envoi message :', err)
    });
  }
}
