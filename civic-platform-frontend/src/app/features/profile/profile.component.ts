import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '@core/services/auth.service';
import { User } from '@core/models/auth.models';
import { UsersService } from '@core/services/users.service';
import { BadgeComponent } from '@shared/components/badge/badge.component';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, RouterModule, ReactiveFormsModule, BadgeComponent],
  template: `
    <div class="min-h-screen bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 py-8">
      <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8" *ngIf="currentUser as user">
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden">
          <div class="bg-gradient-to-r from-indigo-600 to-blue-600 p-6 text-white">
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-4">
                <div class="h-14 w-14 rounded-full bg-white/20 flex items-center justify-center text-2xl font-bold">
                  {{ user.userName.charAt(0).toUpperCase() }}
                </div>
                <div>
                  <h1 class="text-2xl font-bold">{{ user.firstName || '' }} {{ user.lastName || '' }}</h1>
                  <p class="text-indigo-100">{{ '@' + user.userName }}</p>
                </div>
              </div>
              <app-badge [badge]="user.badge" [awardedDate]="user.awardedDate"></app-badge>
            </div>
          </div>

          <form [formGroup]="profileForm" (ngSubmit)="save()" class="p-6 space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div class="bg-blue-50 rounded-xl p-4">
                <label class="text-xs text-blue-700 font-semibold">User Type (read-only)</label>
                <p class="text-lg font-semibold text-blue-900">{{ user.userType }}</p>
              </div>
              <div class="bg-purple-50 rounded-xl p-4">
                <label class="text-xs text-purple-700 font-semibold">Role (read-only)</label>
                <p class="text-lg font-semibold text-purple-900">{{ user.role }}</p>
              </div>
            </div>

            <div class="bg-indigo-50 rounded-xl p-4">
              <h2 class="text-lg font-semibold text-indigo-900 mb-3">Personal Info</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <input class="input" placeholder="First Name" formControlName="firstName" />
                <input class="input" placeholder="Last Name" formControlName="lastName" />
                <input class="input" placeholder="Username" formControlName="userName" />
                <input class="input" placeholder="Birth Date" type="date" formControlName="birthDate" />
              </div>
            </div>

            <div class="bg-green-50 rounded-xl p-4">
              <h2 class="text-lg font-semibold text-green-900 mb-3">Contact Info</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <input class="input" placeholder="Email" type="email" formControlName="email" />
                <input class="input" placeholder="Phone" formControlName="phone" />
                <input class="input md:col-span-2" placeholder="Address" formControlName="address" />
              </div>
            </div>

            <div class="bg-emerald-50 rounded-xl p-4" *ngIf="user.userType === 'DONOR' || user.associationName || user.companyName">
              <h2 class="text-lg font-semibold text-emerald-900 mb-3">Association Info</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <input class="input" placeholder="Association Name" formControlName="associationName" />
                <input class="input" placeholder="Company Name" formControlName="companyName" />
                <input class="input" placeholder="Contact Name" formControlName="contactName" />
                <input class="input" placeholder="Contact Email" type="email" formControlName="contactEmail" />
              </div>
            </div>

            <div class="flex items-center justify-between pt-2">
              <a routerLink="/dashboard" class="text-indigo-600 hover:text-indigo-500 font-medium">← Back to Dashboard</a>
              <button type="submit" [disabled]="isSaving || profileForm.invalid"
                      class="bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg px-5 py-2 font-semibold disabled:opacity-50">
                {{ isSaving ? 'Saving...' : 'Save Profile' }}
              </button>
            </div>

            <p *ngIf="message" class="text-sm font-medium" [class.text-red-600]="messageType==='error'" [class.text-green-700]="messageType==='success'">
              {{ message }}
            </p>
          </form>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .input {
      width: 100%;
      border: 1px solid #d1d5db;
      border-radius: 0.5rem;
      padding: 0.55rem 0.75rem;
      background: #fff;
      outline: none;
    }
    .input:focus {
      border-color: #6366f1;
      box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
    }
  `]
})
export class ProfileComponent {
  currentUser: User | null = null;
  profileForm: FormGroup;
  isSaving = false;
  message = '';
  messageType: 'success' | 'error' = 'success';

  constructor(
    private authService: AuthService,
    private usersService: UsersService,
    private fb: FormBuilder
  ) {
    this.profileForm = this.fb.group({
      userName: ['', [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      firstName: [''],
      lastName: [''],
      phone: [''],
      address: [''],
      birthDate: [''],
      associationName: [''],
      companyName: [''],
      contactName: [''],
      contactEmail: ['', Validators.email]
    });

    this.authService.currentUser$.subscribe(user => {
      this.currentUser = user;
      if (user) {
        this.profileForm.patchValue({
          userName: user.userName,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          phone: user.phone,
          address: user.address,
          birthDate: this.formatDateForInput(user.birthDate),
          associationName: user.associationName,
          companyName: user.companyName,
          contactName: user.contactName,
          contactEmail: user.contactEmail
        });
      }
    });
  }

  // Helper to convert date from backend (object or string) to YYYY-MM-DD format for HTML date input
  private formatDateForInput(dateValue: any): string {
    if (!dateValue) return '';
    
    // If it's already a string in YYYY-MM-DD format, return it
    if (typeof dateValue === 'string') {
      // Check if it's ISO format (YYYY-MM-DDTHH:mm:ss...)
      if (dateValue.includes('T')) {
        return dateValue.split('T')[0];
      }
      return dateValue;
    }
    
    // If it's an object with year, month, day (LocalDate serialization)
    if (typeof dateValue === 'object' && dateValue.year !== undefined) {
      const year = dateValue.year;
      const month = String(dateValue.monthValue || dateValue.month).padStart(2, '0');
      const day = String(dateValue.dayOfMonth || dateValue.day).padStart(2, '0');
      return `${year}-${month}-${day}`;
    }
    
    return '';
  }

  save(): void {
    if (!this.currentUser || this.profileForm.invalid) return;
    this.isSaving = true;
    this.message = '';

    // Only send profile fields - never send userName, email, role, userType, badge, points
    const profileData = {
      firstName: this.profileForm.value.firstName,
      lastName: this.profileForm.value.lastName,
      phone: this.profileForm.value.phone,
      address: this.profileForm.value.address,
      birthDate: this.profileForm.value.birthDate,
      companyName: this.profileForm.value.companyName,
      associationName: this.profileForm.value.associationName,
      contactName: this.profileForm.value.contactName,
      contactEmail: this.profileForm.value.contactEmail
    };

    this.usersService.updateProfile(this.currentUser.id, profileData).subscribe({
      next: (updated) => {
        // Merge updated fields with current user, preserving identity fields
        const refreshed: User = {
          ...this.currentUser!,
          ...updated,
          // Ensure identity fields are never changed
          userType: this.currentUser!.userType,
          role: this.currentUser!.role,
          badge: this.currentUser!.badge,
          points: this.currentUser!.points,
          userName: this.currentUser!.userName,
          email: this.currentUser!.email
        };
        
        // Update AuthService so all components get fresh data
        this.authService.updateCurrentUser(refreshed);
        this.currentUser = refreshed;
        
        this.messageType = 'success';
        this.message = 'Profile updated successfully.';
        this.isSaving = false;
      },
      error: (err) => {
        this.messageType = 'error';
        // Show specific backend error message if available
        this.message = err?.error?.message || err?.message || 'Failed to update profile. Please try again.';
        console.error('Profile update error:', err);
        this.isSaving = false;
      }
    });
  }
}
