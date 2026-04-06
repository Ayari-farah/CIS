import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ProjectsService } from '@core/services/projects.service';

@Component({
  selector: 'app-project-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  template: `
    <div class="max-w-2xl mx-auto p-6">
      <h2 class="text-2xl font-bold mb-6">Create New Project</h2>
      <form [formGroup]="projectForm" (ngSubmit)="onSubmit()" class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">Title *</label>
          <input type="text" formControlName="title" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700">Description</label>
          <textarea formControlName="description" rows="3" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2"></textarea>
        </div>
        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700">Goal Amount *</label>
            <input type="number" formControlName="goalAmount" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700">End Date</label>
            <input type="date" formControlName="endDate" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2">
          </div>
        </div>
        <div class="flex justify-end space-x-3 pt-4">
          <button type="button" (click)="router.navigate(['/projects'])" class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">Cancel</button>
          <button type="submit" [disabled]="projectForm.invalid" class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50">Create Project</button>
        </div>
      </form>
    </div>
  `
})
export class ProjectFormComponent {
  projectForm: FormGroup;

  constructor(
    private fb: FormBuilder,
    public router: Router,
    private projectsService: ProjectsService
  ) {
    this.projectForm = this.fb.group({
      title: ['', Validators.required],
      description: [''],
      goalAmount: ['', [Validators.required, Validators.min(1)]],
      endDate: ['']
    });
  }

  onSubmit(): void {
    if (this.projectForm.valid) {
      this.projectsService.createProject(this.projectForm.value).subscribe({
        next: () => this.router.navigate(['/projects']),
        error: (err) => console.error('Failed to create project:', err)
      });
    }
  }
}
