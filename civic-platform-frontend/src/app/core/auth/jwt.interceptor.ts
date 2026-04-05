import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {

  constructor(private authService: AuthService) {}

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // Skip auth for login and register endpoints
    if (req.url.includes('/auth/login') || req.url.includes('/auth/register')) {
      return next.handle(req);
    }

    const token = this.authService.getAccessToken();
    
    if (token) {
      req = req.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`
        }
      });
    }

    return next.handle(req).pipe(
      catchError((error: any) => {
        if (error.status === 401) {
          // Token expired, try to refresh
          return this.handle401Error(req, next);
        }
        return throwError(error);
      })
    );
  }

  private handle401Error(req: HttpRequest<any>, next: HttpHandler): Observable<any> {
    const refreshToken = this.authService.getRefreshToken();
    
    if (refreshToken) {
      return this.authService.refreshToken({ refreshToken }).pipe(
        catchError((refreshError: any) => {
          // Refresh failed, logout user
          this.authService.logout();
          return throwError(() => refreshError);
        })
      );
    } else {
      // No refresh token, logout user
      this.authService.logout();
      return throwError(() => new Error('No refresh token available'));
    }
  }
}
