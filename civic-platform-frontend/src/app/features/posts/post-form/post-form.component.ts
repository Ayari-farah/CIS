import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { PostsService } from '@core/services/posts.service';

@Component({
  selector: 'app-post-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  template: `
    <div class="max-w-2xl mx-auto p-6">
      <h2 class="text-2xl font-bold mb-6">Create New Post</h2>
      <form [formGroup]="postForm" (ngSubmit)="onSubmit()" class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">Title *</label>
          <input type="text" formControlName="title" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700">Type *</label>
          <select formControlName="type" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2">
            <option value="ANNONCE">Announcement</option>
            <option value="EVENT">Event</option>
            <option value="SUCCESS_STORY">Success Story</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700">Content *</label>
          <textarea formControlName="content" rows="5" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm border px-3 py-2"></textarea>
        </div>
        <div class="flex justify-end space-x-3 pt-4">
          <button type="button" (click)="router.navigate(['/posts'])" class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">Cancel</button>
          <button type="submit" [disabled]="postForm.invalid" class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50">Create Post</button>
        </div>
      </form>
    </div>
  `
})
export class PostFormComponent {
  postForm: FormGroup;

  constructor(
    private fb: FormBuilder,
    public router: Router,
    private postsService: PostsService
  ) {
    this.postForm = this.fb.group({
      title: ['', Validators.required],
      content: ['', Validators.required],
      type: ['ANNONCE', Validators.required]
    });
  }

  onSubmit(): void {
    if (this.postForm.valid) {
      const postData = {
        content: this.postForm.value.title + '\n\n' + this.postForm.value.content,
        type: this.postForm.value.type
      };
      this.postsService.createPost(postData).subscribe({
        next: () => this.router.navigate(['/posts']),
        error: (err) => console.error('Failed to create post:', err)
      });
    }
  }
}
