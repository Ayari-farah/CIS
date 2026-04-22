import { APP_INITIALIZER, ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideHttpClient, withInterceptorsFromDi, HTTP_INTERCEPTORS } from '@angular/common/http';

import { routes } from './app.routes';
import { JwtInterceptor } from './core/auth/jwt.interceptor';
import { AuthService } from './core/services/auth.service';

function initializeAuth(authService: AuthService): () => Promise<void> {
  return () => authService.initializeAuth();
}

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(withInterceptorsFromDi()),
    { provide: HTTP_INTERCEPTORS, useClass: JwtInterceptor, multi: true },
    { provide: APP_INITIALIZER, useFactory: initializeAuth, deps: [AuthService], multi: true }
  ]
};
