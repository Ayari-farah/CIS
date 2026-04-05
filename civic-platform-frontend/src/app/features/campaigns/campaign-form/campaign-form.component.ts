import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { CampaignsService, CampaignRequest, CampaignType } from '@core/services/campaigns.service';

@Component({
  selector: 'app-campaign-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './campaign-form.component.html',
  styleUrls: ['./campaign-form.component.scss']
})
export class CampaignFormComponent {
  campaignForm: FormGroup;
  isLoading = false;
  errorMessage = '';
  campaignTypes = Object.values(CampaignType);

  constructor(
    private fb: FormBuilder,
    private campaignsService: CampaignsService,
    private router: Router
  ) {
    this.campaignForm = this.fb.group({
      name: ['', [Validators.required]],
      type: [CampaignType.FOOD_COLLECTION, [Validators.required]],
      description: [''],
      goalKg: [0],
      goalMeals: [0],
      goalAmount: [0],
      startDate: [''],
      endDate: [''],
      hashtag: ['']
    });
  }

  onSubmit(): void {
    if (this.campaignForm.invalid) {
      this.campaignForm.markAllAsTouched();
      return;
    }

    this.isLoading = true;
    const campaignRequest: CampaignRequest = this.campaignForm.value;

    this.campaignsService.createCampaign(campaignRequest).subscribe({
      next: () => {
        this.router.navigate(['/campaigns']);
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to create campaign';
        this.isLoading = false;
      }
    });
  }
}
