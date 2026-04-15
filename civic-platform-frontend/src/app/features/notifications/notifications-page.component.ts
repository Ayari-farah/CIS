import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { NotificationsService } from '@core/services/notifications.service';
import { AppNotification } from '@core/models/notification.model';

@Component({
  selector: 'app-notifications-page',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './notifications-page.component.html',
  styleUrls: ['./notifications-page.component.scss']
})
export class NotificationsPageComponent implements OnInit {
  items: AppNotification[] = [];
  loading = true;
  page = 0;
  totalPages = 0;
  size = 20;

  constructor(
    private notifications: NotificationsService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.notifications.list(this.page, this.size).subscribe({
      next: (p) => {
        this.items = p.content ?? [];
        this.totalPages = p.totalPages ?? 0;
        this.loading = false;
      },
      error: () => (this.loading = false)
    });
  }

  prev(): void {
    if (this.page > 0) {
      this.page--;
      this.load();
    }
  }

  next(): void {
    if (this.page < this.totalPages - 1) {
      this.page++;
      this.load();
    }
  }

  open(n: AppNotification): void {
    if (!n.readAt) {
      this.notifications.markRead(n.id).subscribe({ next: () => (n.readAt = new Date().toISOString()) });
    }
    if (n.linkUrl) {
      this.router.navigateByUrl(n.linkUrl);
    }
  }

  markAllRead(): void {
    this.notifications.markAllRead().subscribe({
      next: () => {
        this.items.forEach((i) => (i.readAt = i.readAt || new Date().toISOString()));
      }
    });
  }
}
