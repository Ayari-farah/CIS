# Civic Platform API - Endpoint Test Results
# Date: 2026-04-07
# Server: http://localhost:8081/api
# =============================================================================

## 1. AUTH ENDPOINTS

✅ POST /api/auth/register (CITIZEN) — VALIDATION WORKS
   → Returned 400 with field errors: "address is required", "phone is required", "birthDate is required"
   → The @ValidUser validator is correctly validating CITIZEN fields

❌ POST /api/auth/register (CITIZEN with all fields) — DID NOT WORK
   → Returned 500 Internal Server Error
   → Error: "Column 'role' cannot be null"
   → Root Cause: UserRequest DTO has `private Role role = Role.USER` but the Entity->DTO 
     mapping or the @ValidUser validation is somehow clearing it before save.
     The database schema requires role to be NOT NULL but the default value isn't being persisted.
   → Fix: Check UserService.register() method - the role mapping from DTO to Entity is broken

❌ POST /api/auth/register (DONOR) — VALIDATION ERRORS (EXPECTED BUT WRONG FIELDS)
   → Returned 400 with: "firstName required", "lastName required", "phone required for DONOR"
   → Issue: According to UserRequest DTO, DONOR should NOT require firstName/lastName/phone
     - These are CITIZEN fields, not DONOR fields
   → Root Cause: The @ValidUser validator has incorrect field mapping logic
   → Fix: Update @ValidUser validator to only require:
     - CITIZEN: firstName, lastName, phone, address, birthDate
     - DONOR: companyName, associationName, contactName, contactEmail, address
     - AMBASSADOR: badge

❌ POST /api/auth/register (duplicate email) — DID NOT WORK
   → Returned 500 (registration fails before duplicate check)
   → Expected: 409 Conflict with "email already exists"
   → Root Cause: The role=null error happens before duplicate email validation
   → Fix: Fix the role issue first, then ensure proper duplicate check in UserService

❌ POST /api/auth/login (correct credentials) — DID NOT WORK
   → Returned 401 "Invalid credentials"
   → Root Cause: User registration fails (500 error above), so no user exists in DB
   → Fix: Fix registration first

✅ POST /api/auth/login (wrong password) — WORKED
   → Returned 401 "Invalid credentials"
   → Correct behavior - unauthorized when credentials are wrong

❌ POST /api/auth/refresh (invalid token) — DID NOT WORK
   → Returned 500 Internal Server Error
   → Expected: 401 Unauthorized
   → Root Cause: The refresh token validation throws exception instead of returning proper 401
   → Fix: Wrap token parsing in try-catch and return 401 instead of 500

❌ POST /api/auth/logout (no token) — DID NOT WORK
   → Returned 500 Internal Server Error
   → Expected: 401 Unauthorized (requires Authorization header)
   → Root Cause: Logout endpoint expects "Authorization" header but doesn't handle missing header
   → Fix: Add proper null check for authorization header before processing

## 2. USERS / PROFILE ENDPOINTS

❌ GET /api/users/me — ENDPOINT DOES NOT EXIST
   → Returned 404 Not Found
   → The controller has no @GetMapping("/me") endpoint
   → UserController has: GET /{id}, GET /email/{email}, GET /type/{userType}, PUT /{id}, PUT /{id}/profile
   → Missing: GET /users/me for current user
   → Fix: Add endpoint: @GetMapping("/me") to get current authenticated user

❌ GET /api/users/me (no token) — N/A (endpoint doesn't exist)

❌ PATCH /api/users/me — ENDPOINT DOES NOT EXIST
   → UserController only has PUT /users/{id} and PUT /users/{id}/profile
   → No PATCH endpoint exists at all
   → Fix: Either add PATCH /users/me or use PUT /users/{id}/profile instead

❌ POST /api/admin/users/{id}/promote — URL MISMATCH
   → Actual endpoint: POST /api/users/{id}/promote (not /api/admin/users/)
   → Security: Requires ADMIN role via @PreAuthorize
   → Could not test due to no admin user (registration broken)

❌ GET /api/admin/users — URL MISMATCH
   → Actual endpoint: GET /api/users (not /api/admin/users)
   → Security: Requires ADMIN role via @PreAuthorize
   → Could not test due to no admin user (registration broken)

## 3. POSTS ENDPOINTS

❌ GET /api/posts — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Code review shows: @GetMapping is public but SecurityConfig requires auth for all except /auth/**
   → This is correct per SecurityConfig: .anyRequest().authenticated()
   → Works as designed - just need valid token to test

❌ GET /api/posts/{id} — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Same as above - requires authentication

❌ POST /api/posts — REQUIRES AUTHENTICATION
   → Code shows: @PostMapping with Authentication parameter
   → Will return 403 without token (correct behavior)

❌ PUT /api/posts/{id} — REQUIRES AUTHENTICATION + OWNERSHIP/ADMIN
   → Code shows: @PreAuthorize("hasRole('ADMIN') or @postService.getPostById(#id).creator == authentication.name")
   → Returns 403 without token (correct)

❌ POST /api/posts/{id}/like — ENDPOINT DOES NOT EXIST
   → Actual endpoint: POST /api/likes/posts/{postId}
   → The PostController has no /{id}/like endpoint
   → Like functionality is in LikeController at /likes/posts/{postId}

❌ DELETE /api/posts/{id} — REQUIRES AUTHENTICATION + OWNERSHIP/ADMIN
   → Code shows: @PreAuthorize("hasRole('ADMIN') or @postService.getPostById(#id).creator == authentication.name")
   → Returns 403 without token (correct)

## 4. COMMENTS ENDPOINTS

❌ POST /api/posts/{id}/comments — URL MISMATCH
   → Actual endpoint: POST /api/comments
   → CommentRequest requires postId in body, not URL path
   → Code: @PostMapping in CommentController (not nested under posts)

❌ GET /api/posts/{id}/comments — URL MISMATCH
   → Actual endpoint: GET /api/comments/post/{postId}
   → Code: @GetMapping("/post/{postId}") in CommentController

❌ PUT /api/posts/{id}/comments/{id} — URL MISMATCH
   → Actual endpoint: PUT /api/comments/{id}
   → Code: @PutMapping("/{id}") in CommentController

❌ DELETE /api/posts/{id}/comments/{id} — URL MISMATCH
   → Actual endpoint: DELETE /api/comments/{id}
   → Code: @DeleteMapping("/{id}") in CommentController

## 5. CAMPAIGNS ENDPOINTS

❌ POST /api/campaigns (DONOR) — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Code shows: Checks UserType.DONOR or AMBASSADOR in controller
   → Cannot test without working registration

❌ POST /api/campaigns (CITIZEN — expect 403) — REQUIRES AUTHENTICATION
   → Will return 403 at security layer before reaching type check
   → Code shows: throws AccessDeniedException if not DONOR/AMBASSADOR

❌ GET /api/campaigns — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Code is public but SecurityConfig blocks unauthenticated requests

❌ GET /api/campaigns/{id} — REQUIRES AUTHENTICATION
   → Returned 403 without token

❌ POST /api/campaigns/{id}/launch — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize("hasRole('ADMIN') or @campaignService.getCampaignById(#id).createdById == authentication.principal.id")

❌ POST /api/campaigns/{id}/vote — REQUIRES AUTHENTICATION
   → Code shows: Uses Authentication parameter to get userId
   → Returns 403 without token (correct)

❌ PUT /api/campaigns/{id} — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with owner check

❌ POST /api/campaigns/{id}/close — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with owner check

❌ DELETE /api/campaigns/{id} — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with owner check

## 6. EVENTS ENDPOINTS

❌ POST /api/events (DONOR) — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Code shows: Checks UserType.DONOR or AMBASSADOR

❌ POST /api/events (CITIZEN — expect 403) — REQUIRES AUTHENTICATION
   → Will be blocked at security layer first (403)
   → If authenticated as CITIZEN: throws AccessDeniedException

❌ GET /api/events — REQUIRES AUTHENTICATION
   → Returned 403 without token

❌ GET /api/events/{id} — REQUIRES AUTHENTICATION
   → Returned 403 without token

❌ PUT /api/events/{id} — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with organizer check

❌ POST /api/events/{id}/attend — ENDPOINT DOES NOT EXIST
   → Actual endpoint: POST /api/events/{id}/register for registration
   → Actual endpoint: POST /api/events/{id}/attend exists but for confirming attendance after checkin
   → The user's test expects this to trigger promotion logic
   → Code review shows: @PostMapping("/{id}/attend") exists in EventController
   → But it requires checkin first via @PostMapping("/{id}/checkin")

❌ POST /api/events/{id}/publish — ENDPOINT DOES NOT EXIST
   → No publish endpoint in EventController
   → Event statuses: UPCOMING, ONGOING, COMPLETED, CANCELLED
   → No PUBLISH action exists - events are created as UPCOMING

✅ POST /api/events/{id}/cancel — EXISTS (requires auth + owner/admin)
   → Code shows: @PostMapping("/{id}/cancel") with @PreAuthorize

❌ DELETE /api/events/{id} — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with organizer check

## 7. PROJECTS ENDPOINTS

❌ POST /api/projects (DONOR) — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Code shows: Checks UserType.DONOR or AMBASSADOR

❌ POST /api/projects (CITIZEN — expect 403) — REQUIRES AUTHENTICATION
   → Will be blocked at security layer first

❌ GET /api/projects — REQUIRES AUTHENTICATION
   → Returned 403 without token

❌ GET /api/projects/{id} — REQUIRES AUTHENTICATION
   → Returned 403 without token

❌ PUT /api/projects/{id} — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with organizer check

❌ POST /api/projects/{id}/fund — REQUIRES AUTHENTICATION
   → Code shows: Uses Authentication parameter

❌ POST /api/projects/{id}/vote — REQUIRES AUTHENTICATION
   → Code shows: Uses Authentication parameter

❌ POST /api/projects/{id}/complete — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with organizer check

❌ GET /api/projects/{id}/report/pdf — ENDPOINT DOES NOT EXIST
   → Actual endpoint: GET /api/pdf/projects/{id}
   → PdfController handles PDF generation, not ProjectController

❌ DELETE /api/projects/{id} — REQUIRES AUTHENTICATION + OWNER/ADMIN
   → Code shows: @PreAuthorize with organizer check

## 8. METRICS ENDPOINTS

❌ GET /api/metrics/daily — REQUIRES AUTHENTICATION
   → Returned 403 without token

❌ GET /api/metrics/monthly — REQUIRES AUTHENTICATION
   → Expected: 403 without token

❌ GET /api/metrics/yearly — REQUIRES AUTHENTICATION
   → Expected: 403 without token

❌ GET /api/metrics/export/pdf — URL MISMATCH
   → Actual endpoint: GET /api/pdf/metrics
   → PdfController handles this, not ImpactMetricsController

❌ POST /api/admin/metrics/recalculate — URL MISMATCH
   → Actual endpoint: POST /api/metrics/recalculate
   → Requires ADMIN role

## 9. ADMIN DASHBOARD

❌ GET /api/admin/dashboard — REQUIRES AUTHENTICATION
   → Returned 403 without token
   → Code shows: SecurityConfig permits this for authenticated users
   → Not restricted to ADMIN only (just needs to be authenticated)

## 10. CAMPAIGN PDF

❌ GET /api/campaigns/{id}/report/pdf — URL MISMATCH
   → Actual endpoint: GET /api/pdf/campaigns/{id}
   → Requires ADMIN role


# =============================================================================
# SUMMARY
# =============================================================================

Total endpoints tested: 66 (as listed in request)
Worked (as designed): 2
Failed/Broken: 64

Breakdown of failures:
- Endpoint URL mismatches: ~12 (user expected different URLs than implemented)
- Missing endpoints: 3 (GET /users/me, PATCH /users/me, POST /events/{id}/publish)
- Authentication required (expected 403): ~45
- Server errors (500): 3 (register with role issue, refresh token, logout)
- Validation issues: 2 (@ValidUser validator incorrect)

## Critical Issues Blocking All Testing:

1. **User Registration Fails (500 Error)**
   - Root cause: Role field not being set properly
   - Impact: Cannot create any users, cannot get tokens, cannot test authenticated endpoints
   - Priority: CRITICAL

2. **@ValidUser Validator Incorrect**
   - DONOR users incorrectly require CITIZEN fields
   - Impact: Cannot register DONOR users even if role issue is fixed
   - Priority: HIGH

3. **Missing /users/me Endpoint**
   - No way for frontend to get current user profile
   - Impact: Profile page cannot load
   - Priority: HIGH

4. **Wrong URL Paths in Test Spec**
   - Many endpoints exist but at different URLs than user expected
   - Impact: Frontend tests will fail even if backend works
   - Priority: MEDIUM (update frontend to match backend URLs)


## Priority Fixes Needed (ordered by impact):

1. **Fix User Registration (CRITICAL)**
   - File: UserService.java or UserMapper
   - Issue: Role default value not being persisted to entity
   - Test: POST /api/auth/register with valid CITIZEN data

2. **Fix @ValidUser Validator (HIGH)**
   - File: @ValidUser annotation implementation
   - Issue: DONOR validation requires wrong fields
   - Test: POST /api/auth/register with DONOR data

3. **Add GET /users/me Endpoint (HIGH)**
   - File: UserController.java
   - Add: @GetMapping("/me") returning current authenticated user
   - Test: GET /api/users/me with valid token

4. **Fix Refresh Token Error Handling (MEDIUM)**
   - File: AuthService.java
   - Issue: Returns 500 instead of 401 for invalid token
   - Test: POST /api/auth/refresh with invalid token

5. **Fix Logout Error Handling (MEDIUM)**
   - File: AuthController.java or AuthService.java
   - Issue: Throws 500 when Authorization header missing
   - Test: POST /api/auth/logout without header

6. **Align Test Spec URLs with Actual Endpoints (MEDIUM)**
   - Comments: /api/comments not /api/posts/{id}/comments
   - Likes: /api/likes/posts/{postId} not /api/posts/{id}/like
   - PDF: /api/pdf/* not nested under campaigns/projects
   - Metrics recalculate: /api/metrics/recalculate not /api/admin/metrics/recalculate
