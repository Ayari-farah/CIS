import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PostsService, Post, PostStatus } from '@core/services/posts.service';

@Component({
  selector: 'app-admin-posts',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './admin-posts.component.html',
  styleUrls: ['./admin-posts.component.scss']
})
export class AdminPostsComponent implements OnInit {
  posts: Post[] = [];
  isLoading = false;
  errorMessage = '';
  actionId: number | null = null;

  constructor(private postsService: PostsService) {}

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.isLoading = true;
    this.errorMessage = '';
    this.postsService.getPostsByStatus(PostStatus.PENDING).subscribe({
      next: (posts) => {
        this.posts = posts;
        this.isLoading = false;
      },
      error: (err) => {
        this.errorMessage = err.error?.message || 'Failed to load pending posts';
        this.isLoading = false;
      }
    });
  }

  approve(id: number): void {
    this.actionId = id;
    this.postsService.approvePost(id).subscribe({
      next: () => {
        this.posts = this.posts.filter((p) => p.id !== id);
        this.actionId = null;
      },
      error: (err) => {
        this.errorMessage = err.error?.message || 'Approve failed';
        this.actionId = null;
      }
    });
  }

  reject(id: number): void {
    this.actionId = id;
    this.postsService.rejectPost(id).subscribe({
      next: () => {
        this.posts = this.posts.filter((p) => p.id !== id);
        this.actionId = null;
      },
      error: (err) => {
        this.errorMessage = err.error?.message || 'Reject failed';
        this.actionId = null;
      }
    });
  }
}
