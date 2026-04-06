import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { UsersService } from '@core/services/users.service';
import { User } from '@core/models/auth.models';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  users: User[] = [];
  isLoading = false;
  errorMessage = '';

  constructor(private usersService: UsersService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.isLoading = true;
    this.usersService.getAllUsers().subscribe({
      next: (users: User[]) => {
        this.users = users;
        this.isLoading = false;
      },
      error: (err: any) => {
        this.errorMessage = err.error?.message || 'Failed to load users';
        this.isLoading = false;
      }
    });
  }

  deleteUser(id: number): void {
    if (confirm('Are you sure?')) {
      this.usersService.deleteUser(id).subscribe({
        next: () => {
          this.users = this.users.filter((u: User) => u.id !== id);
        },
        error: (err: any) => {
          this.errorMessage = err.error?.message || 'Failed to delete';
        }
      });
    }
  }

  getRoleColor(role: string): string {
    switch (role) {
      case 'ADMIN': return 'bg-red-100 text-red-800';
      default: return 'bg-green-100 text-green-800';
    }
  }
}
