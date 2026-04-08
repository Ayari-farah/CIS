import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Project {
  id: number;
  title: string;
  description?: string;
  goalAmount: number;
  currentAmount: number;
  voteCount: number;
  status?: string;
  startDate?: string;
  completionDate?: string;
  finalReport?: string;
  organizerType?: string;
  createdAt?: string;
  fundingPercentage?: number;
  fullyFunded?: boolean;
}

export interface ProjectFunding {
  id: number;
  projectId: number;
  amount: number;
  fundedAt: string;
}

export interface ProjectRequest {
  title: string;
  description?: string;
  goalAmount: number;
  organizerType?: string;
}

export interface ProjectFundingRequest {
  projectId: number;
  amount: number;
  paymentMethod?: string;
}

@Injectable({ providedIn: 'root' })
export class ProjectsService {
  private readonly API_URL = 'http://localhost:8081/api/projects';

  constructor(private http: HttpClient) {}

  getAllProjects(): Observable<Project[]> {
    return this.http.get<Project[]>(this.API_URL);
  }

  getProjectById(id: number): Observable<Project> {
    return this.http.get<Project>(`${this.API_URL}/${id}`);
  }

  createProject(projectData: ProjectRequest): Observable<Project> {
    return this.http.post<Project>(this.API_URL, projectData);
  }

  updateProject(id: number, projectData: Partial<ProjectRequest>): Observable<Project> {
    return this.http.put<Project>(`${this.API_URL}/${id}`, projectData);
  }

  deleteProject(id: number): Observable<void> {
    return this.http.delete<void>(`${this.API_URL}/${id}`);
  }

  voteForProject(id: number): Observable<void> {
    return this.http.post<void>(`${this.API_URL}/${id}/vote`, {});
  }

  fundProject(fundingData: ProjectFundingRequest): Observable<ProjectFunding> {
    return this.http.post<ProjectFunding>(`${this.API_URL}/${fundingData.projectId}/fund`, fundingData);
  }
}
