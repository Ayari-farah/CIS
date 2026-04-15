export type NotificationType =
  | 'INFO'
  | 'SUCCESS'
  | 'WARNING'
  | 'ENGAGEMENT'
  | 'MODERATION';

export interface AppNotification {
  id: number;
  title: string;
  body: string | null;
  type: NotificationType;
  readAt: string | null;
  linkUrl: string | null;
  createdAt: string;
}

export interface SpringPage<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
}
