import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './core/services/auth.service';
import { User } from './core/models/auth.models';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'Civic Platform';
  currentUser$: Observable<User | null>;
  isSidebarOpen = false;

  constructor(
    private authService: AuthService,
    private router: Router
  ) {
    this.currentUser$ = this.authService.currentUser$;
  }

  toggleSidebar(): void {
    this.isSidebarOpen = !this.isSidebarOpen;
  }

  logout(): void {
    this.authService.logout();
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

  isModerator(): boolean {
    return this.authService.hasRole('MODERATOR');
  }
}
