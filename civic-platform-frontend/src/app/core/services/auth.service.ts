import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, BehaviorSubject, tap } from 'rxjs';
import { AuthResponse, LoginRequest, RegisterRequest, RefreshTokenRequest, User } from '../models/auth.models';
import { ApiResponse } from '../models/common.models';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private readonly API_URL = 'http://localhost:8081/api/auth';
  private readonly TOKEN_KEY = 'auth_token';
  private readonly REFRESH_TOKEN_KEY = 'refresh_token';
  private readonly USER_KEY = 'current_user';

  private currentUserSubject = new BehaviorSubject<User | null>(null);
  public currentUser$ = this.currentUserSubject.asObservable();

  constructor(private http: HttpClient) {
    this.initializeAuthFromStorage();
  }

  private initializeAuthFromStorage(): void {
    const token = localStorage.getItem(this.TOKEN_KEY);
    const userStr = localStorage.getItem(this.USER_KEY);
    
    if (token && userStr) {
      try {
        const user = JSON.parse(userStr);
        this.currentUserSubject.next(user);
      } catch (error) {
        this.clearStorage();
      }
    }
  }

  login(credentials: LoginRequest): Observable<AuthResponse> {
    return this.http.post<AuthResponse>(`${this.API_URL}/login`, credentials).pipe(
      tap(response => this.handleAuthentication(response))
    );
  }

  register(userData: RegisterRequest): Observable<AuthResponse> {
    return this.http.post<AuthResponse>(`${this.API_URL}/register`, userData).pipe(
      tap(response => this.handleAuthentication(response))
    );
  }

  refreshToken(request: RefreshTokenRequest): Observable<AuthResponse> {
    return this.http.post<AuthResponse>(`${this.API_URL}/refresh`, request).pipe(
      tap(response => this.handleAuthentication(response))
    );
  }

  logout(): void {
    const refreshToken = localStorage.getItem(this.REFRESH_TOKEN_KEY);
    if (refreshToken) {
      this.http.post(`${this.API_URL}/logout`, { refreshToken }).subscribe({
        next: () => this.clearStorage(),
        error: () => this.clearStorage()
      });
    } else {
      this.clearStorage();
    }
  }

  getAccessToken(): string | null {
    return localStorage.getItem(this.TOKEN_KEY);
  }

  getRefreshToken(): string | null {
    return localStorage.getItem(this.REFRESH_TOKEN_KEY);
  }

  getCurrentUser(): User | null {
    return this.currentUserSubject.value;
  }

  isLoggedIn(): boolean {
    return !!this.getAccessToken() && !!this.currentUserSubject.value;
  }

  hasRole(role: string): boolean {
    const user = this.currentUserSubject.value;
    return user ? user.role === role : false;
  }

  hasAnyRole(roles: string[]): boolean {
    const user = this.currentUserSubject.value;
    return user ? roles.includes(user.role) : false;
  }

  isAmbassador(): boolean {
    const user = this.currentUserSubject.value;
    return user ? user.userType === 'AMBASSADOR' : false;
  }

  isDonor(): boolean {
    const user = this.currentUserSubject.value;
    return user ? user.userType === 'DONOR' : false;
  }

  isCitizen(): boolean {
    const user = this.currentUserSubject.value;
    return user ? user.userType === 'CITIZEN' : false;
  }

  isParticipant(): boolean {
    const user = this.currentUserSubject.value;
    return user ? user.userType === 'PARTICIPANT' : false;
  }

  getAuthHeaders(): HttpHeaders {
    const token = this.getAccessToken();
    return new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token ? `Bearer ${token}` : ''
    });
  }

  private handleAuthentication(response: AuthResponse): void {
    const user: User = {
      id: response.userId,
      userName: response.userName,
      email: response.email,
      userType: response.userType,
      role: response.role,
      badge: response.badge,
      points: response.points,
      awardedDate: response.awardedDate,
      createdAt: response.createdAt,
      firstName: response.firstName,
      lastName: response.lastName,
      phone: response.phone,
      address: response.address,
      birthDate: response.birthDate,
      companyName: response.companyName,
      associationName: response.associationName,
      contactName: response.contactName,
      contactEmail: response.contactEmail
    };

    localStorage.setItem(this.TOKEN_KEY, response.token);
    localStorage.setItem(this.REFRESH_TOKEN_KEY, response.refreshToken);
    localStorage.setItem(this.USER_KEY, JSON.stringify(user));
    
    this.currentUserSubject.next(user);
  }

  private clearStorage(): void {
    localStorage.removeItem(this.TOKEN_KEY);
    localStorage.removeItem(this.REFRESH_TOKEN_KEY);
    localStorage.removeItem(this.USER_KEY);
    this.currentUserSubject.next(null);
  }

  updateCurrentUser(user: User): void {
    localStorage.setItem(this.USER_KEY, JSON.stringify(user));
    this.currentUserSubject.next(user);
  }
}
