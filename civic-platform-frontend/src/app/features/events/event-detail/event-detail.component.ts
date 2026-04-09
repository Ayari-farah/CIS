import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { AuthService } from '@core/services/auth.service';
import { EventsService, Event, EventStatus } from '@core/services/events.service';

@Component({
  selector: 'app-event-detail',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './event-detail.component.html',
  styleUrls: ['./event-detail.component.scss']
})
export class EventDetailComponent implements OnInit {
  readonly EventStatus = EventStatus;

  event: Event | null = null;
  isLoading = false;
  errorMessage = '';
  registrationLoading = false;
  actionMessage = '';

  statusLoading = false;

  isRegistered = false;
  registrationStatus: string | null = null;

  showDeleteModal = false;
  deleteLoading = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private eventsService: EventsService,
    private authService: AuthService
  ) {}

  isAdminRoute(): boolean {
    return this.router.url.split('?')[0].startsWith('/admin');
  }

  eventsListPath(): string {
    return this.isAdminRoute() ? '/admin/events' : '/events';
  }

  /** Platform admins review events; they do not register as participants. */
  showParticipantRegistration(): boolean {
    return !this.authService.isAdmin();
  }

  isPlatformAdmin(): boolean {
    return this.authService.isAdmin();
  }

  /** Organizer or platform admin may change event lifecycle. */
  canManageEventLifecycle(): boolean {
    return this.isOrganizer() || this.isPlatformAdmin();
  }

  editEventLink(): (string | number)[] {
    if (!this.event) {
      return [this.eventsListPath()];
    }
    return this.isAdminRoute()
      ? ['/admin/events', this.event.id, 'edit']
      : ['/events', this.event.id, 'edit'];
  }

  openDeleteModal(): void {
    this.showDeleteModal = true;
  }

  cancelDelete(): void {
    this.showDeleteModal = false;
  }

  confirmDelete(): void {
    if (!this.event) {
      return;
    }
    this.deleteLoading = true;
    this.eventsService.deleteEvent(this.event.id).subscribe({
      next: () => {
        this.router.navigateByUrl(this.eventsListPath());
      },
      error: (err) => {
        this.actionMessage = err.error?.message || 'Could not delete event';
        this.deleteLoading = false;
        this.showDeleteModal = false;
      }
    });
  }

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadEvent(Number(id));
    }
  }

  loadEvent(id: number): void {
    this.isLoading = true;
    this.errorMessage = '';
    this.eventsService.getEventById(id).subscribe({
      next: (event) => {
        this.event = event;
        this.isLoading = false;
        if (this.showParticipantRegistration()) {
          this.loadRegistrationStatus(id);
        } else {
          this.isRegistered = false;
          this.registrationStatus = null;
        }
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load event';
        this.isLoading = false;
      }
    });
  }

  private loadRegistrationStatus(eventId: number): void {
    this.eventsService.getRegistrationStatus(eventId).subscribe({
      next: (s) => {
        this.isRegistered = s.registered;
        this.registrationStatus = s.status;
      },
      error: () => {
        this.isRegistered = false;
        this.registrationStatus = null;
      }
    });
  }

  register(): void {
    if (!this.event) return;
    this.registrationLoading = true;
    this.actionMessage = '';
    this.eventsService.registerForEvent(this.event.id).subscribe({
      next: () => {
        this.registrationLoading = false;
        this.isRegistered = true;
        this.registrationStatus = 'REGISTERED';
        this.actionMessage = 'You are registered for this event.';
        this.loadEvent(this.event.id);
      },
      error: (error) => {
        this.registrationLoading = false;
        this.actionMessage = error.error?.message || 'Could not register';
      }
    });
  }

  cancelRegistration(): void {
    if (!this.event) return;
    this.registrationLoading = true;
    this.actionMessage = '';
    this.eventsService.cancelRegistration(this.event.id).subscribe({
      next: () => {
        this.registrationLoading = false;
        this.isRegistered = false;
        this.registrationStatus = null;
        this.actionMessage = 'Registration cancelled.';
        this.loadEvent(this.event.id);
      },
      error: (error) => {
        this.registrationLoading = false;
        this.actionMessage = error.error?.message || 'Could not cancel';
      }
    });
  }

  isOrganizer(): boolean {
    if (!this.event?.organizerId) return false;
    const u = this.authService.getCurrentUser();
    return u != null && u.id === this.event.organizerId;
  }

  transitionStatus(status: EventStatus): void {
    if (!this.event) return;
    this.statusLoading = true;
    this.actionMessage = '';
    this.eventsService.transitionEventStatus(this.event.id, status).subscribe({
      next: (ev) => {
        this.event = ev;
        this.statusLoading = false;
        this.actionMessage = 'Event status updated.';
        if (this.showParticipantRegistration()) {
          this.loadRegistrationStatus(ev.id);
        }
      },
      error: (err) => {
        this.statusLoading = false;
        this.actionMessage = err.error?.message || 'Could not update status';
      }
    });
  }

  getStatusLabel(): string {
    if (!this.registrationStatus) return '';
    if (this.registrationStatus === 'COMPLETED') return 'Attended';
    if (this.registrationStatus === 'REGISTERED') return 'Registered';
    if (this.registrationStatus === 'CHECKED_IN') return 'Checked in';
    return this.registrationStatus.replace(/_/g, ' ');
  }
}
