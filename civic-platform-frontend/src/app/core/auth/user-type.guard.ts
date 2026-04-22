import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.service';
import { UserType } from '../models/auth.models';

@Injectable({
  providedIn: 'root'
})
export class UserTypeGuard implements CanActivate {

  constructor(private authService: AuthService, private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> | Promise<boolean> | boolean {

    if (!this.authService.isLoggedIn()) {
      this.authService.loginRedirect(state.url);
      return false;
    }

    if (this.authService.isAdmin()) {
      this.router.navigate(['/admin/dashboard']);
      return false;
    }

    const allowedUserTypes = route.data['userTypes'] as UserType[];

    if (allowedUserTypes && allowedUserTypes.length > 0) {
      const currentUser = this.authService.getCurrentUser();
      const allowed =
        currentUser != null &&
        !!currentUser.userType &&
        allowedUserTypes.includes(currentUser.userType);

      if (!allowed) {
        this.router.navigate(['/dashboard'], { queryParams: { unauthorized: 'user-type' } });
        return false;
      }
    }

    return true;
  }
}
