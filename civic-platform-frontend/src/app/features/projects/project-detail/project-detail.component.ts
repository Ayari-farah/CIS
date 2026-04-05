import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { ProjectsService, Project } from '@core/services/projects.service';

@Component({
  selector: 'app-project-detail',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './project-detail.component.html',
  styleUrls: ['./project-detail.component.scss']
})
export class ProjectDetailComponent implements OnInit {
  project: Project | null = null;
  isLoading = false;
  errorMessage = '';

  constructor(
    private route: ActivatedRoute,
    private projectsService: ProjectsService
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadProject(Number(id));
    }
  }

  loadProject(id: number): void {
    this.isLoading = true;
    this.projectsService.getProjectById(id).subscribe({
      next: (project) => {
        this.project = project;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load project';
        this.isLoading = false;
      }
    });
  }

  vote(): void {
    if (this.project) {
      this.projectsService.voteForProject(this.project.id).subscribe({
        next: () => {
          this.project!.voteCount++;
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'Failed to vote';
        }
      });
    }
  }
}
