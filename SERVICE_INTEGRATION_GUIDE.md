# ms_gestionUser - Service Integration Guide

This document explains how other services should integrate with `ms_gestionUser`.

## 1) Purpose and Responsibilities

`ms_gestionUser` is the owner of user business profile data.

- Identity and authentication are handled by Keycloak.
- User profile and business state are handled by `ms_gestionUser`.
- Other services must consume this service over HTTP and must not write to its database directly.

## 2) Upstream and Downstream Dependencies

- **Keycloak**: JWT validation (resource server) and user administration actions (password, role sync, enable/disable).
- **MySQL**: persistence of local user profile (`utilisateurs` table).
- **Eureka**: service registration and discovery (`spring.application.name=ms-gestionUser`).
- **SMTP**: closure email notification.

`ms_gestionUser` does not currently call other domain microservices directly.

## 3) Security Contract for Consumers

All requests to protected endpoints must include:

- `Authorization: Bearer <access_token>`

Token expectations:

- Token issuer must match the configured Keycloak realm issuer.
- Realm roles from Keycloak are mapped to Spring authorities with `ROLE_` prefix.
- Example: Keycloak role `ADMIN` becomes authority `ROLE_ADMIN`.

## 4) Discovery and Base URL

Use one of the following approaches:

- **Service discovery** via Eureka service id: `ms-gestionUser`
- **Direct URL** (local default): `http://localhost:8087`
- **Gateway route** if your platform standardizes access through API Gateway

Base API path:

- `/api/users`

## 5) Endpoint Reference

Note: examples assume JSON payloads and a valid Bearer token.

### 5.1 Get or initialize current user profile

- **Method**: `GET`
- **Path**: `/api/users/me`
- **Who calls this**: user-facing services right after login/session start
- **Behavior**:
  - Returns existing local user profile by Keycloak `sub`
  - If no local profile exists yet, one is auto-created from JWT claims

Example request:

```http
GET /api/users/me HTTP/1.1
Authorization: Bearer <token>
```

Example response (200):

```json
{
  "idUser": 17,
  "keycloakId": "cf8a6c0a-8f30-4d04-9f1c-21f4d6888d29",
  "nom": "Doe",
  "prenom": "Jane",
  "email": "jane.doe@example.com",
  "role": "DONOR",
  "actif": true,
  "deletionRequested": false
}
```

### 5.2 Update current user profile

- **Method**: `PUT`
- **Path**: `/api/users/me/update`
- **Who calls this**: profile management services/UIs
- **Behavior**:
  - Updates user business fields
  - Validates phone/capacity constraints
  - Synchronizes name and role into Keycloak

Example request:

```http
PUT /api/users/me/update HTTP/1.1
Authorization: Bearer <token>
Content-Type: application/json
```

```json
{
  "nom": "Doe",
  "prenom": "Jane",
  "telephone": "22123456",
  "address": "Tunis",
  "role": "DONOR",
  "donorCompanyName": "GreenFoods",
  "taxIdNumber": "TN123456"
}
```

### 5.3 List all users (admin)

- **Method**: `GET`
- **Path**: `/api/users/all`
- **Required role**: `ADMIN`
- **Who calls this**: admin/back-office services

Example request:

```http
GET /api/users/all HTTP/1.1
Authorization: Bearer <admin-token>
```

### 5.4 Toggle user active status (admin)

- **Method**: `PUT`
- **Path**: `/api/users/toggle-status/{id}?active=<true|false>`
- **Required role**: `ADMIN`
- **Behavior**:
  - Updates local `isActif`
  - Tries to synchronize Keycloak `enabled` status

Example request:

```http
PUT /api/users/toggle-status/17?active=false HTTP/1.1
Authorization: Bearer <admin-token>
```

### 5.5 Request own account deletion

- **Method**: `POST`
- **Path**: `/api/users/me/request-deletion`
- **Who calls this**: end-user-facing apps
- **Behavior**:
  - Sets local `isDeletionRequested=true`
  - Returns informational message

### 5.6 Approve account deletion

- **Method**: `POST`
- **Path**: `/api/users/approve-deletion/{id}`
- **Intended caller**: admin services
- **Behavior**:
  - Sets local `isActif=false` and `isDeletionRequested=false`
  - Sends closure email

### 5.7 Change own password

- **Method**: `POST`
- **Path**: `/api/users/me/change-password`
- **Who calls this**: account settings services/UIs
- **Behavior**:
  - Resets Keycloak password through admin API
  - Returns detailed error if Keycloak permission is missing

Example request:

```http
POST /api/users/me/change-password HTTP/1.1
Authorization: Bearer <token>
Content-Type: application/json
```

```json
{
  "newPassword": "StrongPassword@123"
}
```

### 5.8 Update user by database ID

- **Method**: `PUT`
- **Path**: `/api/users/update/{id}`
- **Intended caller**: admin/system services
- **Behavior**:
  - Updates fields by local DB user id
  - Synchronizes name and role to Keycloak

### 5.9 Authentication smoke test

- **Method**: `GET`
- **Path**: `/api/users/test-auth`
- **Purpose**: validate token wiring end-to-end

## 6) Recommended Integration Pattern for Other Services

1. Validate user authentication in your edge/gateway.
2. Forward the same Bearer token when calling `ms_gestionUser`.
3. Resolve current profile via `GET /api/users/me`.
4. Cache profile short-term only (if needed) and refresh on profile changes.
5. Treat `actif=false` as blocked/inactive for business actions in your service.
6. Handle `401`, `403`, `404`, and `5xx` explicitly with clear fallback behavior.

## 7) Error Handling Expectations

Typical statuses:

- `200`/`201`: success
- `400`: invalid payload/business rule violation
- `401`: missing/invalid token
- `403`: insufficient privileges
- `404`: user not found in local storage or Keycloak operation target missing
- `500`: integration failure (Keycloak/SMTP/internal)

Example error shape (consumer recommendation):

```json
{
  "timestamp": "2026-04-22T15:10:00Z",
  "status": 403,
  "error": "Forbidden",
  "message": "Permission refused for Keycloak operation",
  "path": "/api/users/me/change-password"
}
```

## 8) Data Contract Guidance

For other microservices:

- Persist only references (`idUser`, `keycloakId`, `email`) as needed.
- Do not duplicate mutable profile fields unless required for performance/reporting.
- If duplicating fields, implement synchronization strategy and ownership rules.

## 9) Operational Requirements

- Configure timeouts and retries (safe retries for idempotent reads).
- Use circuit breaker for resilience.
- Propagate correlation/tracing headers (e.g. `X-Request-Id`).
- Monitor:
  - API latency and error rates
  - Keycloak admin API failures
  - SMTP delivery failures

## 10) Implementation Checklist (for each consuming service)

- [ ] Keycloak JWT propagation enabled
- [ ] Client for `ms-gestionUser` endpoints implemented
- [ ] Role-aware error handling (`401/403`) implemented
- [ ] Inactive user (`actif=false`) business guard implemented
- [ ] Integration tests for happy path + forbidden + unavailable dependency
- [ ] Observability/tracing headers propagated

## 11) Notes About Current Security Rules

Current configuration explicitly restricts:

- `/api/users/all/**`
- `/api/users/delete/**`
- `/api/users/toggle-status/**`

Other endpoints are authenticated but not all are explicitly role-scoped in the security config.  
If your platform requires stricter authorization (for example admin-only for `/approve-deletion/{id}` and `/update/{id}`), enforce it in `ms_gestionUser` before relying on it system-wide.
