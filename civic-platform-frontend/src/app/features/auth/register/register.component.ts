import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '@core/services/auth.service';
import { RegisterRequest } from '@core/models/auth.models';
import { UserType, Role } from '@core/models/auth.models';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent {
  registerForm: FormGroup;
  isLoading = false;
  errorMessage = '';
  showPassword = false;
  userTypes = Object.values(UserType);
  roles = Object.values(Role);

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router
  ) {
    this.registerForm = this.fb.group({
      userName: ['', [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      userType: [UserType.CITIZEN, [Validators.required]],
      role: [Role.USER],
      firstName: [''],
      lastName: [''],
      phone: ['']
    });
  }

  onSubmit(): void {
    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    this.isLoading = true;
    this.errorMessage = '';

    const registerRequest: RegisterRequest = {
      userName: this.registerForm.value.userName!,
      email: this.registerForm.value.email!,
      password: this.registerForm.value.password!,
      userType: this.registerForm.value.userType!,
      role: this.registerForm.value.role,
      firstName: this.registerForm.value.firstName,
      lastName: this.registerForm.value.lastName,
      phone: this.registerForm.value.phone
    };

    this.authService.register(registerRequest).subscribe({
      next: () => {
        this.router.navigate(['/dashboard']);
      },
      error: (error) => {
        console.error('Register error:', error);
        if (error.error?.errors) {
          const errorMessages = Object.entries(error.error.errors)
            .map(([field, msg]) => `${field}: ${msg}`)
            .join(', ');
          this.errorMessage = errorMessages;
        } else if (error.error?.message) {
          this.errorMessage = error.error.message;
        } else if (error.status === 409) {
          this.errorMessage = 'Email or username already exists';
        } else if (error.status === 0) {
          this.errorMessage = 'Cannot connect to server. Please try again later.';
        } else {
          this.errorMessage = `Registration failed (${error.status}). Please try again.`;
        }
        this.isLoading = false;
      },
      complete: () => {
        this.isLoading = false;
      }
    });
  }

  togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }

  get userName() { return this.registerForm.get('userName'); }
  get email() { return this.registerForm.get('email'); }
  get password() { return this.registerForm.get('password'); }
  get userType() { return this.registerForm.get('userType'); }
}
