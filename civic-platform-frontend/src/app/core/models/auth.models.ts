export enum UserType {
  AMBASSADOR = 'AMBASSADOR',
  DONOR = 'DONOR',
  CITIZEN = 'CITIZEN',
  PARTICIPANT = 'PARTICIPANT'
}

export enum Role {
  USER = 'USER',
  ADMIN = 'ADMIN',
  MODERATOR = 'MODERATOR'
}

export enum Badge {
  COEUR = 'COEUR',
  DOR = 'DOR',
  MOBILISATEUR = 'MOBILISATEUR',
  PIONNIER = 'PIONNIER',
  LOCAL = 'LOCAL',
  REGIONAL = 'REGIONAL',
  NATIONAL = 'NATIONAL'
}

export interface User {
  id: number;
  userName: string;
  email: string;
  userType: UserType;
  role: Role;
  createdAt: string;
  
  // AMBASSADOR fields
  badge?: Badge;
  awardedDate?: string;
  
  // DONOR fields
  companyName?: string;
  associationName?: string;
  contactName?: string;
  contactEmail?: string;
  address?: string;
  
  // CITIZEN fields
  firstName?: string;
  lastName?: string;
  phone?: string;
  birthDate?: string;
  
  // PARTICIPANT fields
  points?: number;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  userName: string;
  email: string;
  password: string;
  userType: UserType;
  role?: Role;
  
  // AMBASSADOR fields
  badge?: Badge;
  
  // DONOR fields
  companyName?: string;
  associationName?: string;
  contactName?: string;
  contactEmail?: string;
  address?: string;
  
  // CITIZEN fields
  firstName?: string;
  lastName?: string;
  phone?: string;
  birthDate?: string;
  
  // PARTICIPANT fields
  points?: number;
}

export interface RefreshTokenRequest {
  refreshToken: string;
}

export interface AuthResponse {
  token: string;
  refreshToken: string;
  userType: string;
  role: string;
  userId: number;
  userName: string;
  email: string;
}
