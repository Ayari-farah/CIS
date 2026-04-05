import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MetricsService, DashboardStats, ImpactMetrics } from '@core/services/metrics.service';

@Component({
  selector: 'app-metrics',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './metrics.component.html',
  styleUrls: ['./metrics.component.scss']
})
export class MetricsComponent implements OnInit {
  stats: DashboardStats | null = null;
  metrics: ImpactMetrics | null = null;
  isLoading = false;
  errorMessage = '';

  constructor(private metricsService: MetricsService) {}

  ngOnInit(): void {
    this.loadStats();
    this.loadMetrics();
  }

  loadStats(): void {
    this.isLoading = true;
    this.metricsService.getDashboardStats().subscribe({
      next: (stats) => {
        this.stats = stats;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load stats';
        this.isLoading = false;
      }
    });
  }

  loadMetrics(): void {
    const today = new Date().toISOString().split('T')[0];
    this.metricsService.getDailyMetrics(today).subscribe({
      next: (metrics) => {
        this.metrics = metrics;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load metrics';
      }
    });
  }

  exportPdf(): void {
    this.metricsService.exportMetricsPdf().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = 'metrics-report.pdf';
        link.click();
        window.URL.revokeObjectURL(url);
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to export PDF';
      }
    });
  }
}
