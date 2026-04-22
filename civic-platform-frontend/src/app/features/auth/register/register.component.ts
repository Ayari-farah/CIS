import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { AuthService } from '@core/services/auth.service';
import { RegisterRequest, UserType } from '@core/models/auth.models';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  step: 1 | 2 = 1;
  userType: 'CITIZEN' | 'DONOR' | null = null;
  
  registerForm: FormGroup;
  isLoading = false;
  errorMessage = '';
  showPassword = false;
  private returnUrl = '/dashboard';

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.returnUrl = this.route.snapshot.queryParamMap.get('returnUrl') || '/dashboard';
    this.registerForm = this.fb.group({
      userName: ['', [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      phone: [''],
      address: [''],
      birthDate: [''],
      associationName: ['']
    });
  }

  ngOnInit(): void {
    if (this.authService.isLoggedIn()) {
      this.router.navigateByUrl(this.returnUrl);
    }
  }

  selectUserType(type: 'CITIZEN' | 'DONOR'): void {
    this.userType = type;
    this.step = 2;
    this.errorMessage = '';

    if (type === UserType.DONOR) {
      this.registerForm.get('associationName')?.setValidators([Validators.required]);
      this.registerForm.get('birthDate')?.clearValidators();
    } else {
      this.registerForm.get('associationName')?.clearValidators();
      this.registerForm.get('birthDate')?.setValidators([Validators.required]);
    }

    this.registerForm.get('associationName')?.updateValueAndValidity();
    this.registerForm.get('birthDate')?.updateValueAndValidity();
  }

  goBack(): void {
    this.step = 1;
    this.userType = null;
    this.errorMessage = '';
    this.registerForm.reset();
  }

  onSubmit(): void {
    if (this.registerForm.invalid || !this.userType) {
      this.registerForm.markAllAsTouched();
      return;
    }

    this.isLoading = true;
    this.errorMessage = '';

    const formValue = this.registerForm.value;
    
    const registerRequest: RegisterRequest = {
      userName: formValue.userName,
      email: formValue.email,
      password: formValue.password,
      userType: this.userType as UserType.CITIZEN | UserType.DONOR,
      firstName: formValue.firstName,
      lastName: formValue.lastName,
      ...(formValue.phone && { phone: formValue.phone }),
      ...(formValue.address && { address: formValue.address }),
      ...(this.userType === 'CITIZEN' && { birthDate: formValue.birthDate }),
      ...(this.userType === 'DONOR' && { associationName: formValue.associationName })
    };

    this.authService.register(registerRequest).subscribe({
      next: () => {
        this.router.navigateByUrl(this.returnUrl);
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
  get firstName() { return this.registerForm.get('firstName'); }
  get lastName() { return this.registerForm.get('lastName'); }
  get phone() { return this.registerForm.get('phone'); }
  get address() { return this.registerForm.get('address'); }
  get birthDate() { return this.registerForm.get('birthDate'); }
  get associationName() { return this.registerForm.get('associationName'); }
}
