import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { PostsService, Post, Comment, CommentRequest } from '@core/services/posts.service';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-post-detail',
  standalone: true,
  imports: [CommonModule, RouterModule, ReactiveFormsModule],
  templateUrl: './post-detail.component.html',
  styleUrls: ['./post-detail.component.scss']
})
export class PostDetailComponent implements OnInit {
  post: Post | null = null;
  comments: Comment[] = [];
  isLoading = false;
  errorMessage = '';
  commentForm: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private postsService: PostsService,
    private fb: FormBuilder
  ) {
    this.commentForm = this.fb.group({
      content: ['', [Validators.required]]
    });
  }

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadPost(Number(id));
      this.loadComments(Number(id));
    }
  }

  loadPost(id: number): void {
    this.isLoading = true;
    this.postsService.getPostById(id).subscribe({
      next: (post) => {
        this.post = post;
        this.isLoading = false;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load post';
        this.isLoading = false;
      }
    });
  }

  loadComments(postId: number): void {
    this.postsService.getCommentsByPost(postId).subscribe({
      next: (comments) => {
        this.comments = comments;
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to load comments';
      }
    });
  }

  addComment(): void {
    if (this.commentForm.invalid || !this.post) {
      return;
    }

    const commentRequest: CommentRequest = {
      content: this.commentForm.value.content!,
      postId: this.post.id
    };

    this.postsService.createComment(commentRequest).subscribe({
      next: () => {
        this.commentForm.reset();
        this.loadComments(this.post!.id);
      },
      error: (error) => {
        this.errorMessage = error.error?.message || 'Failed to add comment';
      }
    });
  }

  likePost(): void {
    if (this.post) {
      this.postsService.likePost(this.post.id).subscribe({
        next: () => {
          this.post!.likesCount++;
        },
        error: (error) => {
          this.errorMessage = error.error?.message || 'Failed to like post';
        }
      });
    }
  }
}
