import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Observable } from 'rxjs';
import { MetricsService, DashboardStats } from '@core/services/metrics.service';
import { AuthService } from '@core/services/auth.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  dashboardStats$!: Observable<DashboardStats>;
  isLoading = true;
  error: string | null = null;

  constructor(
    private metricsService: MetricsService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.loadDashboardStats();
  }

  loadDashboardStats(): void {
    this.isLoading = true;
    this.error = null;
    
    this.metricsService.getDashboardStats().subscribe({
      next: (stats) => {
        this.dashboardStats$ = new Observable(observer => {
          observer.next(stats);
          observer.complete();
        });
        this.isLoading = false;
      },
      error: (err) => {
        this.error = 'Failed to load dashboard statistics';
        this.isLoading = false;
        console.error('Dashboard error:', err);
      }
    });
  }

  getUserName(): string {
    const user = this.authService.getCurrentUser();
    return user?.userName || 'User';
  }

  getUserType(): string {
    const user = this.authService.getCurrentUser();
    return user?.userType || 'USER';
  }

  isAdmin(): boolean {
    return this.authService.hasRole('ADMIN');
  }

  isModerator(): boolean {
    return this.authService.hasRole('MODERATOR');
  }

  isAmbassador(): boolean {
    return this.authService.isAmbassador();
  }

  isDonor(): boolean {
    return this.authService.isDonor();
  }

  isCitizen(): boolean {
    return this.authService.isCitizen();
  }

  isParticipant(): boolean {
    return this.authService.isParticipant();
  }

  exportMetricsPdf(): void {
    this.metricsService.exportMetricsPdf().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'metrics-report.pdf';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        window.URL.revokeObjectURL(url);
      },
      error: (err) => {
        console.error('Error exporting PDF:', err);
        this.error = 'Failed to export metrics PDF';
      }
    });
  }

  refreshStats(): void {
    this.loadDashboardStats();
  }
}
