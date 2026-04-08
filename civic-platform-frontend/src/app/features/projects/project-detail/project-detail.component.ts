import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { ProjectsService, Project } from '@core/services/projects.service';

@Component({
  selector: 'app-project-detail',
  standalone: true,
  imports: [CommonModule, RouterModule, ReactiveFormsModule],
  templateUrl: './project-detail.component.html',
  styleUrls: ['./project-detail.component.scss']
})
export class ProjectDetailComponent implements OnInit {
  project: Project | null = null;
  isLoading = false;
  errorMessage = '';

  showDonateModal = false;
  donateForm: FormGroup;
  isDonating = false;
  donateSuccess = false;

  constructor(
    private route: ActivatedRoute,
    private projectsService: ProjectsService,
    private fb: FormBuilder
  ) {
    this.donateForm = this.fb.group({
      amount: [25, [Validators.required, Validators.min(1)]],
      cardHolder: ['', Validators.required],
      cardNumber: ['', [Validators.required, Validators.pattern(/^\d{4}\s?\d{4}\s?\d{4}\s?\d{4}$/)]],
      expiry: ['', [Validators.required, Validators.pattern(/^(0[1-9]|1[0-2])\/\d{2}$/)]],
      cvc: ['', [Validators.required, Validators.pattern(/^\d{3,4}$/)]]
    });
  }

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadProject(Number(id));
    }
  }

  loadProject(id: number): void {
    this.isLoading = true;
    this.projectsService.getProjectById(id).subscribe({
      next: (project) => {
        this.project = project;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load project';
        this.isLoading = false;
      }
    });
  }

  openDonateModal(): void {
    this.showDonateModal = true;
    this.donateSuccess = false;
    this.errorMessage = '';
    this.donateForm.reset({ amount: 25 });
  }

  closeDonateModal(): void {
    this.showDonateModal = false;
  }

  formatCardNumber(event: Event): void {
    const input = event.target as HTMLInputElement;
    let value = input.value.replace(/\D/g, '').substring(0, 16);
    value = value.replace(/(.{4})/g, '$1 ').trim();
    input.value = value;
    this.donateForm.get('cardNumber')?.setValue(value, { emitEvent: false });
  }

  formatExpiry(event: Event): void {
    const input = event.target as HTMLInputElement;
    let value = input.value.replace(/\D/g, '').substring(0, 4);
    if (value.length >= 3) {
      value = value.substring(0, 2) + '/' + value.substring(2);
    }
    input.value = value;
    this.donateForm.get('expiry')?.setValue(value, { emitEvent: false });
  }

  submitDonation(): void {
    if (this.donateForm.invalid || !this.project) {
      this.donateForm.markAllAsTouched();
      return;
    }
    this.isDonating = true;
    this.errorMessage = '';

    this.projectsService.fundProject({
      projectId: this.project.id,
      amount: this.donateForm.value.amount,
      paymentMethod: 'CARD'
    }).subscribe({
      next: () => {
        this.project!.currentAmount += this.donateForm.value.amount;
        this.isDonating = false;
        this.donateSuccess = true;
        setTimeout(() => {
          this.closeDonateModal();
        }, 2500);
      },
      error: (err) => {
        this.errorMessage = err.error?.message || 'Donation failed. Please try again.';
        this.isDonating = false;
      }
    });
  }

  getProgress(): number {
    if (!this.project?.goalAmount || this.project.goalAmount === 0) return 0;
    return Math.min(100, Math.round((this.project.currentAmount / this.project.goalAmount) * 100));
  }

  getStatusColor(status: string): string {
    switch (status) {
      case 'ACTIVE': return 'bg-green-100 text-green-800';
      case 'COMPLETED': return 'bg-blue-100 text-blue-800';
      case 'PENDING': return 'bg-yellow-100 text-yellow-800';
      default: return 'bg-gray-100 text-gray-700';
    }
  }
}
