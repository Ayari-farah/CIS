import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export enum CampaignType {
  FOOD_COLLECTION = 'FOOD_COLLECTION',
  FUNDRAISING = 'FUNDRAISING',
  VOLUNTEER = 'VOLUNTEER',
  AWARENESS = 'AWARENESS'
}

export enum CampaignStatus {
  DRAFT = 'DRAFT',
  ACTIVE = 'ACTIVE',
  COMPLETED = 'COMPLETED'
}

export interface Campaign {
  id: number;
  name: string;
  description?: string;
  type: CampaignType;
  status: CampaignStatus;
  startDate?: string;
  endDate?: string;
  targetAmount?: number;
  currentAmount?: number;
  voteCount: number;
  createdAt?: string;
  createdBy?: string;
}

export interface CampaignRequest {
  name: string;
  description?: string;
  type: CampaignType;
  startDate?: string;
  endDate?: string;
  targetAmount?: number;
}

@Injectable({ providedIn: 'root' })
export class CampaignsService {
  private readonly API_URL = 'http://localhost:8081/api/campaigns';

  constructor(private http: HttpClient) {}

  getAllCampaigns(): Observable<Campaign[]> {
    return this.http.get<Campaign[]>(this.API_URL);
  }

  getCampaignById(id: number): Observable<Campaign> {
    return this.http.get<Campaign>(`${this.API_URL}/${id}`);
  }

  createCampaign(campaignData: CampaignRequest): Observable<Campaign> {
    return this.http.post<Campaign>(this.API_URL, campaignData);
  }

  updateCampaign(id: number, campaignData: Partial<CampaignRequest>): Observable<Campaign> {
    return this.http.put<Campaign>(`${this.API_URL}/${id}`, campaignData);
  }

  deleteCampaign(id: number): Observable<void> {
    return this.http.delete<void>(`${this.API_URL}/${id}`);
  }

  voteForCampaign(id: number): Observable<void> {
    return this.http.post<void>(`${this.API_URL}/${id}/vote`, {});
  }

  changeCampaignStatus(id: number, status: CampaignStatus): Observable<Campaign> {
    return this.http.patch<Campaign>(`${this.API_URL}/${id}/status`, { status });
  }
}
