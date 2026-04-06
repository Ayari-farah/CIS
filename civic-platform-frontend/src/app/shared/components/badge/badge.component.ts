import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Badge } from '@core/models/auth.models';

@Component({
  selector: 'app-badge',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div *ngIf="badge && badge !== 'NONE'" class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"
         [ngStyle]="{ 'background-color': getBadgeColor(), color: getTextColor() }">
      <span class="mr-1">{{ getBadgeIcon() }}</span>
      {{ badge }}
      <span *ngIf="showDate && awardedDate" class="ml-1 opacity-75">• {{ formatDate(awardedDate) }}</span>
    </div>
    <div *ngIf="!badge || badge === 'NONE'" class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-500">
      <span class="mr-1">○</span>
      No Badge
    </div>
  `,
  styles: []
})
export class BadgeComponent {
  @Input() badge: Badge | string | undefined | null = Badge.NONE;
  @Input() awardedDate: string | undefined;
  @Input() showDate: boolean = true;

  getBadgeColor(): string {
    switch (this.badge) {
      case Badge.BRONZE:
        return '#cd7f32';
      case Badge.SILVER:
        return '#c0c0c0';
      case Badge.GOLD:
        return '#ffd700';
      case Badge.PLATINUM:
        return '#e5e4e2';
      default:
        return '#9ca3af';
    }
  }

  getTextColor(): string {
    // Use dark text for light backgrounds (SILVER, PLATINUM, GOLD)
    if (this.badge === Badge.SILVER || this.badge === Badge.PLATINUM || this.badge === Badge.GOLD) {
      return '#374151';
    }
    // Use white text for dark backgrounds (BRONZE)
    return '#ffffff';
  }

  getBadgeIcon(): string {
    switch (this.badge) {
      case Badge.BRONZE:
        return '🥉';
      case Badge.SILVER:
        return '🥈';
      case Badge.GOLD:
        return '🥇';
      case Badge.PLATINUM:
        return '💎';
      default:
        return '○';
    }
  }

  formatDate(dateStr: string): string {
    const date = new Date(dateStr);
    return date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
  }
}
