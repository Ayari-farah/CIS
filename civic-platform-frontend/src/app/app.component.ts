import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './core/services/auth.service';
import { User } from './core/models/auth.models';
import { BadgeComponent } from './shared/components/badge/badge.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterModule, BadgeComponent],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'Civic Platform';
  currentUser$: Observable<User | null>;
  isSidebarOpen = false;
  isUserMenuOpen = false;

  constructor(
    private authService: AuthService,
    private router: Router
  ) {
    this.currentUser$ = this.authService.currentUser$;
  }

  toggleSidebar(): void {
    this.isSidebarOpen = !this.isSidebarOpen;
  }

  toggleUserMenu(): void {
    this.isUserMenuOpen = !this.isUserMenuOpen;
  }

  closeUserMenu(): void {
    this.isUserMenuOpen = false;
  }

  logout(): void {
    this.authService.logout();
    this.isUserMenuOpen = false;
    this.router.navigate(['/login']);
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn();
  }

  isAmbassador(): boolean {
    return this.authService.isAmbassador();
  }

  isDonor(): boolean {
    return this.authService.isDonor();
  }

  isCitizen(): boolean {
    return this.authService.isCitizen();
  }

  isParticipant(): boolean {
    return this.authService.isParticipant();
  }

  isAdmin(): boolean {
    return this.authService.hasRole('ADMIN');
  }
}
