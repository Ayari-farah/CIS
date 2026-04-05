import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { CampaignsService, Campaign } from '@core/services/campaigns.service';

@Component({
  selector: 'app-campaign-detail',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './campaign-detail.component.html',
  styleUrls: ['./campaign-detail.component.scss']
})
export class CampaignDetailComponent implements OnInit {
  campaign: Campaign | null = null;
  isLoading = false;
  errorMessage = '';

  constructor(
    private route: ActivatedRoute,
    private campaignsService: CampaignsService
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadCampaign(Number(id));
    }
  }

  loadCampaign(id: number): void {
    this.isLoading = true;
    this.campaignsService.getCampaignById(id).subscribe({
      next: (campaign) => {
        this.campaign = campaign;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load campaign';
        this.isLoading = false;
      }
    });
  }

  vote(): void {
    if (this.campaign) {
      this.campaignsService.voteForCampaign(this.campaign.id).subscribe({
        next: () => {
          if (this.campaign) {
            this.campaign.voteCount = (this.campaign.voteCount || 0) + 1;
          }
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'Failed to vote';
        }
      });
    }
  }
}
