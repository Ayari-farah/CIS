export interface ApiResponse<T> {
  data?: T;
  message?: string;
  errors?: Record<string, string>;
  status?: number;
}

export interface PaginatedResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
}

export interface ErrorResponse {
  timestamp: string;
  status: number;
  message: string;
  errors?: Record<string, string>;
  path?: string;
}
