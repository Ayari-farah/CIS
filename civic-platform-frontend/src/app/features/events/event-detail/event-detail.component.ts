import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { EventsService, Event } from '@core/services/events.service';

@Component({
  selector: 'app-event-detail',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './event-detail.component.html',
  styleUrls: ['./event-detail.component.scss']
})
export class EventDetailComponent implements OnInit {
  event: Event | null = null;
  isLoading = false;
  errorMessage = '';

  constructor(
    private route: ActivatedRoute,
    private eventsService: EventsService
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadEvent(Number(id));
    }
  }

  loadEvent(id: number): void {
    this.isLoading = true;
    this.eventsService.getEventById(id).subscribe({
      next: (event) => {
        this.event = event;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load event';
        this.isLoading = false;
      }
    });
  }

  register(): void {
    if (this.event) {
      this.eventsService.registerForEvent(this.event.id).subscribe({
        next: () => {
          this.loadEvent(this.event!.id);
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'Failed to register';
        }
      });
    }
  }
}
