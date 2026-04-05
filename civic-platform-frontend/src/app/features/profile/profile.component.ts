import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '@core/services/auth.service';
import { User } from '@core/models/auth.models';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, RouterModule],
  template: `
    <div class="min-h-screen bg-gray-50 py-12">
      <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-white shadow rounded-lg p-6">
          <h1 class="text-2xl font-bold text-gray-900 mb-6">My Profile</h1>
          
          <div *ngIf="currentUser$ | async as user" class="space-y-4">
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-500">Username</label>
                <p class="mt-1 text-lg text-gray-900">{{ user.userName }}</p>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-500">Email</label>
                <p class="mt-1 text-lg text-gray-900">{{ user.email }}</p>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-500">User Type</label>
                <p class="mt-1 text-lg text-gray-900">{{ user.userType }}</p>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-500">Role</label>
                <p class="mt-1 text-lg text-gray-900">{{ user.role }}</p>
              </div>
            </div>

            <div class="border-t pt-4 mt-6">
              <a routerLink="/dashboard" class="text-indigo-600 hover:text-indigo-500 text-sm font-medium">
                ← Back to Dashboard
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  `
})
export class ProfileComponent {
  currentUser$: Observable<User | null>;

  constructor(private authService: AuthService) {
    this.currentUser$ = this.authService.currentUser$;
  }
}
