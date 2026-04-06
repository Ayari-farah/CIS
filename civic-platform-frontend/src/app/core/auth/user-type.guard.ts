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
    
    // Check if user is logged in
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login'], { 
        queryParams: { returnUrl: state.url } 
      });
      return false;
    }

    // Get allowed user types from route data
    const allowedUserTypes = route.data['userTypes'] as UserType[];
    
    if (allowedUserTypes && allowedUserTypes.length > 0) {
      const currentUser = this.authService.getCurrentUser();
      
      if (!currentUser || !allowedUserTypes.includes(currentUser.userType)) {
        this.router.navigate(['/dashboard'], { queryParams: { unauthorized: 'user-type' } });
        return false;
      }
    }

    return true;
  }
}
