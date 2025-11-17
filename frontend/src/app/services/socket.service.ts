import { Injectable } from '@angular/core';
import { io, Socket } from 'socket.io-client';

@Injectable({
  providedIn: 'root'
})
export class SocketService {
  private socket: Socket;

  constructor() {
    this.socket = io('http://localhost:3000'); // backend NestJS
  }

  // écouter un event
  listen(event: string) {
    return new Promise((resolve) => {
      this.socket.on(event, (data) => {
        resolve(data);
      });
    });
  }

  // envoyer un event
  emit(event: string, data: any) {
    this.socket.emit(event, data);
  }
}
