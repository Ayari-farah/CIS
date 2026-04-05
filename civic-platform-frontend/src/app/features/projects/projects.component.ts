import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ProjectsService, Project } from '@core/services/projects.service';

@Component({
  selector: 'app-projects',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './projects.component.html',
  styleUrls: ['./projects.component.scss']
})
export class ProjectsComponent implements OnInit {
  projects: Project[] = [];
  isLoading = false;
  errorMessage = '';

  constructor(private projectsService: ProjectsService) {}

  ngOnInit(): void {
    this.loadProjects();
  }

  loadProjects(): void {
    this.isLoading = true;
    this.projectsService.getAllProjects().subscribe({
      next: (projects) => {
        this.projects = projects;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load projects';
        this.isLoading = false;
      }
    });
  }

  vote(project: Project): void {
    this.projectsService.voteForProject(project.id).subscribe({
      next: () => {
        project.voteCount++;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to vote';
      }
    });
  }
}
