import { ApplicationConfig, provideBrowserGlobalErrorListeners, provideZoneChangeDetection, importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { LucideAngularModule, Home, Lightbulb, MessageSquare, Bell, Plus, User, DollarSign, Heart, BarChart, FileText, ThumbsUp, ThumbsDown, Save, MessageCircle, Search } from 'lucide-angular';

import { routes } from './app.routes';

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes),
    provideHttpClient(),

    
    importProvidersFrom(
      LucideAngularModule.pick({ 
          Home,
        Lightbulb,
        Bell,
        Plus,
        MessageSquare,
        User,
        DollarSign,
        Heart,
        BarChart,
        FileText,
        ThumbsUp,
        ThumbsDown,
        Save,
        MessageCircle,
        Search
      })
    )
  ]
};
