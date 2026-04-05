import { Routes } from '@angular/router';
import { AuthGuard } from './core/auth/auth.guard';
import { RoleGuard } from './core/auth/role.guard';

export const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
  { path: 'login', loadComponent: () => import('./features/auth/login/login.component').then(m => m.LoginComponent) },
  { path: 'register', loadComponent: () => import('./features/auth/register/register.component').then(m => m.RegisterComponent) },
  
  {
    path: 'dashboard',
    loadComponent: () => import('./features/dashboard/dashboard.component').then(m => m.DashboardComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'users',
    loadComponent: () => import('./features/users/users.component').then(m => m.UsersComponent),
    canActivate: [AuthGuard, RoleGuard],
    data: { roles: ['ADMIN'] }
  },
  
  {
    path: 'users/:id',
    loadComponent: () => import('./features/users/user-detail/user-detail.component').then(m => m.UserDetailComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'campaigns',
    loadComponent: () => import('./features/campaigns/campaigns.component').then(m => m.CampaignsComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'campaigns/:id',
    loadComponent: () => import('./features/campaigns/campaign-detail/campaign-detail.component').then(m => m.CampaignDetailComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'campaigns/new',
    loadComponent: () => import('./features/campaigns/campaign-form/campaign-form.component').then(m => m.CampaignFormComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'events',
    loadComponent: () => import('./features/events/events.component').then(m => m.EventsComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'events/:id',
    loadComponent: () => import('./features/events/event-detail/event-detail.component').then(m => m.EventDetailComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'projects',
    loadComponent: () => import('./features/projects/projects.component').then(m => m.ProjectsComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'projects/:id',
    loadComponent: () => import('./features/projects/project-detail/project-detail.component').then(m => m.ProjectDetailComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'posts',
    loadComponent: () => import('./features/posts/posts.component').then(m => m.PostsComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'posts/:id',
    loadComponent: () => import('./features/posts/post-detail/post-detail.component').then(m => m.PostDetailComponent),
    canActivate: [AuthGuard]
  },
  
  {
    path: 'metrics',
    loadComponent: () => import('./features/metrics/metrics.component').then(m => m.MetricsComponent),
    canActivate: [AuthGuard, RoleGuard],
    data: { roles: ['ADMIN', 'MODERATOR'] }
  },
  
  {
    path: 'profile',
    loadComponent: () => import('./features/profile/profile.component').then(m => m.ProfileComponent),
    canActivate: [AuthGuard]
  },
  
  { path: '**', redirectTo: '/dashboard' }
];
