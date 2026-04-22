import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, from, throwError } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {

  constructor(private authService: AuthService, private router: Router) {}

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return from(this.authService.getValidAccessToken()).pipe(
      switchMap((token) => {
        const authReq = token
          ? req.clone({
              setHeaders: {
                Authorization: `Bearer ${token}`
              }
            })
          : req;

        return next.handle(authReq);
      }),
      catchError((error: any) => {
        if (error.status === 401) {
          this.authService.loginRedirect(this.router.url);
        }
        return throwError(() => error);
      })
    );
  }
}
