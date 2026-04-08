#!/bin/bash
# =============================================================================
# Civic Platform API - Complete CURL Test Scenarios
# =============================================================================
# Base URL: http://localhost:8080/api (as specified)
# Note: Actual server config shows port 8081 with context-path /api
# =============================================================================

# =============================================================================
# VARIABLES - Set these after running the initial commands
# =============================================================================
TOKEN=""                # filled after login
REFRESH_TOKEN=""        # filled after login
ADMIN_TOKEN=""          # filled after admin login
DONOR_TOKEN=""          # filled after donor login
CITIZEN_TOKEN=""        # filled after citizen login
USER_ID=""              # filled after register
DONOR_ID=""             # filled after donor register
CAMPAIGN_ID=""
EVENT_ID=""
PROJECT_ID=""
POST_ID=""
COMMENT_ID=""

# =============================================================================
# 1. AUTH ENDPOINTS
# =============================================================================

echo "=========================================="
echo "1. AUTH ENDPOINTS"
echo "=========================================="

# Register — CITIZEN
echo ""
echo "### Register — CITIZEN ✅ Happy path"
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "CITIZEN",
    "firstName": "Aymen",
    "lastName": "Ben Ali",
    "userName": "aymen123",
    "email": "aymen@test.com",
    "password": "Test1234!",
    "phone": "55123456",
    "address": "12 Rue de Tunis",
    "birthDate": "1998-05-15"
  }'
# → Copy returned id into: USER_ID="<value>"

echo ""
echo "### Register — CITIZEN ❌ Missing required field (no email)"
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "CITIZEN",
    "firstName": "Aymen",
    "userName": "testuser",
    "password": "Test1234!"
  }'
# Expect: 400 with field error on email

echo ""
echo "### Register — CITIZEN ❌ Invalid email format"
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "CITIZEN",
    "firstName": "Aymen",
    "lastName": "Ben Ali",
    "userName": "aymen456",
    "email": "invalid-email",
    "password": "Test1234!"
  }'
# Expect: 400 with field error on email

echo ""
echo "### Register — DONOR ✅ Happy path"
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "DONOR",
    "userName": "sarra_donor",
    "email": "sarra@assoc.com",
    "password": "Test1234!",
    "companyName": "EcoTN SARL",
    "associationName": "Green Tunisia",
    "contactName": "Sarra Gharbi",
    "contactEmail": "contact@ecotn.com",
    "address": "5 Avenue Habib"
  }'
# → Copy returned id into: DONOR_ID="<value>"

echo ""
echo "### Register — AMBASSADOR ✅ Happy path"
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "AMBASSADOR",
    "userName": "ambassador1",
    "email": "ambassador@test.com",
    "password": "Test1234!",
    "badge": "GOLD",
    "firstName": "Mohamed",
    "lastName": "Salah"
  }'

echo ""
echo "### Login — CITIZEN ✅ Happy path (store token)"
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "aymen@test.com",
    "password": "Test1234!"
  }'
# → Copy token into: TOKEN="<value>"
# → Copy refreshToken into: REFRESH_TOKEN="<value>"

echo ""
echo "### Login — DONOR ✅ Happy path (store token)"
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "sarra@assoc.com",
    "password": "Test1234!"
  }'
# → Copy token into: DONOR_TOKEN="<value>"

echo ""
echo "### Login ❌ Wrong password"
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "aymen@test.com",
    "password": "wrongpass"
  }'
# Expect: 401

echo ""
echo "### Login ❌ Non-existent user"
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "nonexistent@test.com",
    "password": "Test1234!"
  }'
# Expect: 401

echo ""
echo "### Refresh token ✅ Happy path"
curl -X POST http://localhost:8080/api/auth/refresh \
  -H "Content-Type: application/json" \
  -d "{ \"refreshToken\": \"$REFRESH_TOKEN\" }"

echo ""
echo "### Refresh token ❌ Invalid refresh token"
curl -X POST http://localhost:8080/api/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{ "refreshToken": "invalidtoken123" }'
# Expect: 401

echo ""
echo "### Logout ✅ Happy path"
curl -X POST http://localhost:8080/api/auth/logout \
  -H "Authorization: Bearer $TOKEN"


# =============================================================================
# 2. USER / PROFILE ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "2. USER / PROFILE ENDPOINTS"
echo "=========================================="

echo ""
echo "### GET all users (ADMIN only) ✅ Happy path"
curl -X GET http://localhost:8080/api/users \
  -H "Authorization: Bearer $ADMIN_TOKEN"

echo ""
echo "### GET all users ❌ Non-admin tries"
curl -X GET http://localhost:8080/api/users \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### GET user by ID ✅ Happy path"
curl -X GET http://localhost:8080/api/users/$USER_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET user by ID ❌ Non-existent user"
curl -X GET http://localhost:8080/api/users/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET user by email ✅ Happy path"
curl -X GET http://localhost:8080/api/users/email/aymen@test.com \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET users by type ✅ CITIZEN"
curl -X GET http://localhost:8080/api/users/type/CITIZEN \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET users by type ✅ DONOR"
curl -X GET http://localhost:8080/api/users/type/DONOR \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET users by type ✅ AMBASSADOR"
curl -X GET http://localhost:8080/api/users/type/AMBASSADOR \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET user count by type"
curl -X GET http://localhost:8080/api/users/count/CITIZEN \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### CREATE user (POST /users) ✅ Happy path"
curl -X POST http://localhost:8080/api/users \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "CITIZEN",
    "userName": "created_user",
    "email": "created@test.com",
    "password": "Test1234!",
    "firstName": "Created",
    "lastName": "User"
  }'

echo ""
echo "### UPDATE user (PUT /users/{id}) ✅ Own profile"
curl -X PUT http://localhost:8080/api/users/$USER_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "userName": "aymen123_updated",
    "email": "aymen@test.com",
    "password": "Test1234!",
    "userType": "CITIZEN",
    "firstName": "Aymen Updated",
    "lastName": "Ben Ali Updated",
    "phone": "55000001",
    "address": "99 Rue Nouvelle"
  }'

echo ""
echo "### UPDATE profile (PUT /users/{id}/profile) ✅ Happy path"
curl -X PUT http://localhost:8080/api/users/$USER_ID/profile \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Aymen",
    "lastName": "Ben Ali",
    "phone": "55000001",
    "address": "99 Rue Nouvelle",
    "birthDate": "1998-05-15"
  }'

echo ""
echo "### UPDATE profile ❌ Try to update another user's profile"
curl -X PUT http://localhost:8080/api/users/999/profile \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "firstName": "Hacker" }'
# Expect: 403 or 404

echo ""
echo "### PROMOTE user to AMBASSADOR (ADMIN only) ✅ Happy path"
curl -X POST http://localhost:8080/api/users/$USER_ID/promote \
  -H "Authorization: Bearer $ADMIN_TOKEN"

echo ""
echo "### PROMOTE user ❌ Non-admin tries"
curl -X POST http://localhost:8080/api/users/$USER_ID/promote \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### DELETE user (ADMIN only) ✅ Happy path"
# First create a temp user to delete
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "userType": "CITIZEN",
    "userName": "temp_user",
    "email": "temp@delete.com",
    "password": "Test1234!",
    "firstName": "Temp",
    "lastName": "User"
  }'
# Then delete with: curl -X DELETE http://localhost:8080/api/users/{id} -H "Authorization: Bearer $ADMIN_TOKEN"


# =============================================================================
# 3. POSTS ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "3. POSTS ENDPOINTS"
echo "=========================================="

echo ""
echo "### POST — create post ✅ Happy path"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "STATUS",
    "content": "This is my first post on the platform!"
  }'
# → Copy returned id into: POST_ID="<value>"

echo ""
echo "### POST — create post ✅ EVENT_ANNOUNCEMENT"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "EVENT_ANNOUNCEMENT",
    "content": "Join us for the upcoming charity event!"
  }'

echo ""
echo "### POST — create post ✅ TESTIMONIAL"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "TESTIMONIAL",
    "content": "My experience with this platform has been amazing!"
  }'

echo ""
echo "### POST — create post ✅ CAMPAIGN_ANNOUNCEMENT"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "CAMPAIGN_ANNOUNCEMENT",
    "content": "New campaign launching soon!",
    "campaignId": 1
  }'

echo ""
echo "### POST — create post ❌ No token"
curl -X POST http://localhost:8080/api/posts \
  -H "Content-Type: application/json" \
  -d '{ "type": "STATUS", "content": "test" }'
# Expect: 401

echo ""
echo "### POST — create post ❌ Missing content field"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "type": "STATUS" }'
# Expect: 400

echo ""
echo "### POST — create post ❌ Missing type field"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "content": "no type here" }'
# Expect: 400

echo ""
echo "### GET — all posts ✅"
curl -X GET http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — all posts ❌ No token"
curl -X GET http://localhost:8080/api/posts
# Expect: 401

echo ""
echo "### GET — single post ✅"
curl -X GET http://localhost:8080/api/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — single post ❌ Non-existent post"
curl -X GET http://localhost:8080/api/posts/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — posts by status ✅ PENDING"
curl -X GET http://localhost:8080/api/posts/status/PENDING \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — posts by status ✅ ACCEPTED"
curl -X GET http://localhost:8080/api/posts/status/ACCEPTED \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — posts by campaign ✅"
curl -X GET http://localhost:8080/api/posts/campaign/1 \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### PUT — update post ✅ Happy path"
curl -X PUT http://localhost:8080/api/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "TESTIMONIAL",
    "content": "Updated content for my post."
  }'

echo ""
echo "### PUT — update post ❌ Non-existent post"
curl -X PUT http://localhost:8080/api/posts/99999 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "type": "STATUS", "content": "test" }'
# Expect: 404

echo ""
echo "### POST — approve post (ADMIN only) ✅"
curl -X POST http://localhost:8080/api/posts/$POST_ID/approve \
  -H "Authorization: Bearer $ADMIN_TOKEN"

echo ""
echo "### POST — approve post ❌ Non-admin tries"
curl -X POST http://localhost:8080/api/posts/$POST_ID/approve \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### POST — reject post (ADMIN only) ✅"
curl -X POST http://localhost:8080/api/posts/$POST_ID/reject \
  -H "Authorization: Bearer $ADMIN_TOKEN"

echo ""
echo "### DELETE — delete post ✅ Happy path"
# Create a temp post first
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "type": "STATUS", "content": "Temp post to delete" }'
# Then delete: curl -X DELETE http://localhost:8080/api/posts/{id} -H "Authorization: Bearer $TOKEN"
# Expect: 204

echo ""
echo "### DELETE — delete post ❌ Non-existent post"
curl -X DELETE http://localhost:8080/api/posts/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — confirm deletion"
curl -X GET http://localhost:8080/api/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404


# =============================================================================
# 4. COMMENTS ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "4. COMMENTS ENDPOINTS"
echo "=========================================="

# First recreate a post to comment on
echo ""
echo "### Create a post for comments"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "STATUS",
    "content": "Post for commenting tests"
  }'
# → Copy id to POST_ID_FOR_COMMENTS="<value>"

echo ""
echo "### POST — add comment ✅ Happy path"
curl -X POST http://localhost:8080/api/comments \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{ \"content\": \"Great post, I totally agree!\", \"postId\": $POST_ID }"
# → Copy returned id into: COMMENT_ID="<value>"

echo ""
echo "### POST — add comment ❌ No token"
curl -X POST http://localhost:8080/api/comments \
  -H "Content-Type: application/json" \
  -d '{ "content": "test", "postId": 1 }'
# Expect: 401

echo ""
echo "### POST — add comment ❌ Missing content"
curl -X POST http://localhost:8080/api/comments \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{ \"postId\": $POST_ID }"
# Expect: 400

echo ""
echo "### POST — add comment ❌ Missing postId"
curl -X POST http://localhost:8080/api/comments \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "content": "test" }'
# Expect: 400

echo ""
echo "### GET — comment by ID ✅"
curl -X GET http://localhost:8080/api/comments/$COMMENT_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — comment by ID ❌ Non-existent"
curl -X GET http://localhost:8080/api/comments/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — comments by post ✅"
curl -X GET http://localhost:8080/api/comments/post/$POST_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — comments by author ✅"
curl -X GET http://localhost:8080/api/comments/author/$USER_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### PUT — update comment ✅ Happy path"
curl -X PUT http://localhost:8080/api/comments/$COMMENT_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "content": "Updated comment content.", "postId": 1 }'

echo ""
echo "### PUT — update comment ❌ Non-existent"
curl -X PUT http://localhost:8080/api/comments/99999 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "content": "test", "postId": 1 }'
# Expect: 404

echo ""
echo "### PUT — update comment ❌ Not owner (use different user's token)"
# curl -X PUT http://localhost:8080/api/comments/$COMMENT_ID \
#   -H "Authorization: Bearer $OTHER_USER_TOKEN" \
#   -H "Content-Type: application/json" \
#   -d '{ "content": "hacked", "postId": 1 }'
# Expect: 403

echo ""
echo "### DELETE — delete comment ✅ Happy path"
# Create a temp comment first
curl -X POST http://localhost:8080/api/comments \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{ \"content\": \"Temp comment to delete\", \"postId\": $POST_ID }"
# Then delete: curl -X DELETE http://localhost:8080/api/comments/{id} -H "Authorization: Bearer $TOKEN"
# Expect: 204

echo ""
echo "### DELETE — delete comment ❌ Non-existent"
curl -X DELETE http://localhost:8080/api/comments/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — confirm comment deleted (should not be in list)"
curl -X GET http://localhost:8080/api/comments/post/$POST_ID \
  -H "Authorization: Bearer $TOKEN"


# =============================================================================
# 5. LIKES ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "5. LIKES ENDPOINTS"
echo "=========================================="

# Create a post to like
echo ""
echo "### Create a post for likes testing"
curl -X POST http://localhost:8080/api/posts \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "type": "STATUS", "content": "Post to test likes" }'
# → Copy id to POST_ID_FOR_LIKES="<value>"

echo ""
echo "### POST — like a post ✅ Happy path"
curl -X POST http://localhost:8080/api/likes/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### POST — like a post ❌ No token"
curl -X POST http://localhost:8080/api/likes/posts/$POST_ID
# Expect: 401

echo ""
echo "### POST — like a post ❌ Non-existent post"
curl -X POST http://localhost:8080/api/likes/posts/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### POST — like same post twice ❌ Already liked"
curl -X POST http://localhost:8080/api/likes/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN"
# Expect: 409 or 400 "already liked"

echo ""
echo "### GET — check if post is liked ✅ (should return true)"
curl -X GET http://localhost:8080/api/likes/posts/$POST_ID/check \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — likes count for post ✅"
curl -X GET http://localhost:8080/api/likes/posts/$POST_ID/count \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### DELETE — unlike post ✅ Happy path"
curl -X DELETE http://localhost:8080/api/likes/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### DELETE — unlike post ❌ Not liked yet"
curl -X DELETE http://localhost:8080/api/likes/posts/$POST_ID \
  -H "Authorization: Bearer $TOKEN"
# Expect: 400 or 404

echo ""
echo "### GET — check if post is liked after unlike ✅ (should return false)"
curl -X GET http://localhost:8080/api/likes/posts/$POST_ID/check \
  -H "Authorization: Bearer $TOKEN"


# =============================================================================
# 6. CAMPAIGNS ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "6. CAMPAIGNS ENDPOINTS"
echo "=========================================="

echo ""
echo "### POST — create campaign ✅ Happy path (DONOR token)"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Feed Tunis 2025",
    "type": "FOOD_COLLECTION",
    "description": "Collect food for families in need",
    "neededAmount": 5000.00,
    "goalKg": 1000,
    "goalMeals": 3000,
    "startDate": "2025-06-01",
    "endDate": "2025-06-30",
    "hashtag": "#FeedTunis"
  }'
# → Copy returned id into: CAMPAIGN_ID="<value>"

echo ""
echo "### POST — create campaign ✅ FUNDRAISING"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Education Fund",
    "type": "FUNDRAISING",
    "description": "Support education initiatives",
    "neededAmount": 10000.00,
    "goalAmount": 15000.00,
    "startDate": "2025-07-01",
    "endDate": "2025-07-31"
  }'

echo ""
echo "### POST — create campaign ✅ VOLUNTEER"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Beach Cleanup",
    "type": "VOLUNTEER",
    "description": "Join our volunteer team",
    "startDate": "2025-08-01",
    "endDate": "2025-08-15"
  }'

echo ""
echo "### POST — create campaign ✅ AWARENESS"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Climate Awareness",
    "type": "AWARENESS",
    "description": "Raise awareness about climate change",
    "hashtag": "#ClimateAction"
  }'

echo ""
echo "### POST — create campaign ❌ CITIZEN tries (403)"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "name": "Test", "type": "FOOD_COLLECTION" }'
# Expect: 403

echo ""
echo "### POST — create campaign ❌ Missing name"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "type": "FOOD_COLLECTION" }'
# Expect: 400

echo ""
echo "### POST — create campaign ❌ Missing type"
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "name": "Test Campaign" }'
# Expect: 400

echo ""
echo "### GET — all campaigns ✅"
curl -X GET http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — all campaigns ❌ No token"
curl -X GET http://localhost:8080/api/campaigns
# Expect: 401

echo ""
echo "### GET — single campaign ✅"
curl -X GET http://localhost:8080/api/campaigns/$CAMPAIGN_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — single campaign ❌ Non-existent"
curl -X GET http://localhost:8080/api/campaigns/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — campaigns by status ✅ DRAFT"
curl -X GET http://localhost:8080/api/campaigns/status/DRAFT \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — campaigns by status ✅ ACTIVE"
curl -X GET http://localhost:8080/api/campaigns/status/ACTIVE \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — campaigns by status ✅ COMPLETED"
curl -X GET http://localhost:8080/api/campaigns/status/COMPLETED \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — campaigns by status ✅ CANCELLED"
curl -X GET http://localhost:8080/api/campaigns/status/CANCELLED \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### PUT — update campaign ✅ Happy path"
curl -X PUT http://localhost:8080/api/campaigns/$CAMPAIGN_ID \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Feed Tunis 2025 — Updated",
    "type": "FOOD_COLLECTION",
    "description": "Updated description.",
    "neededAmount": 7000.00
  }'

echo ""
echo "### PUT — update campaign ❌ Non-owner tries"
# curl -X PUT http://localhost:8080/api/campaigns/$CAMPAIGN_ID \
#   -H "Authorization: Bearer $OTHER_DONOR_TOKEN" \
#   -H "Content-Type: application/json" \
#   -d '{ "name": "Hacked", "type": "FOOD_COLLECTION" }'
# Expect: 403

echo ""
echo "### POST — launch campaign ✅"
curl -X POST http://localhost:8080/api/campaigns/$CAMPAIGN_ID/launch \
  -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 200, status = ACTIVE

echo ""
echo "### POST — launch campaign ❌ Non-owner"
curl -X POST http://localhost:8080/api/campaigns/$CAMPAIGN_ID/launch \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### POST — vote on campaign ✅"
curl -X POST http://localhost:8080/api/campaigns/$CAMPAIGN_ID/vote \
  -H "Authorization: Bearer $TOKEN"
# Expect: 200, vote count incremented

echo ""
echo "### POST — vote on campaign ❌ No token"
curl -X POST http://localhost:8080/api/campaigns/$CAMPAIGN_ID/vote
# Expect: 401

echo ""
echo "### POST — vote twice ❌ Already voted"
curl -X POST http://localhost:8080/api/campaigns/$CAMPAIGN_ID/vote \
  -H "Authorization: Bearer $TOKEN"
# Expect: 409 "already voted"

echo ""
echo "### POST — close campaign ✅"
curl -X POST http://localhost:8080/api/campaigns/$CAMPAIGN_ID/close \
  -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 200, status = COMPLETED

echo ""
echo "### POST — cancel campaign ✅"
# First create a new campaign to cancel
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "name": "To Cancel", "type": "VOLUNTEER" }'
# Then: curl -X POST http://localhost:8080/api/campaigns/{id}/cancel -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 200, status = CANCELLED

echo ""
echo "### POST — activate campaigns ready (ADMIN only) ✅"
curl -X POST http://localhost:8080/api/campaigns/activate-ready \
  -H "Authorization: Bearer $ADMIN_TOKEN"

echo ""
echo "### POST — activate campaigns ready ❌ Non-admin"
curl -X POST http://localhost:8080/api/campaigns/activate-ready \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### DELETE — delete campaign ✅ Happy path"
# Create a temp campaign first
curl -X POST http://localhost:8080/api/campaigns \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "name": "Temp Campaign", "type": "AWARENESS" }'
# Then delete: curl -X DELETE http://localhost:8080/api/campaigns/{id} -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 204

echo ""
echo "### DELETE — delete campaign ❌ Non-owner"
curl -X DELETE http://localhost:8080/api/campaigns/1 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### GET — confirm deletion"
curl -X GET http://localhost:8080/api/campaigns/$CAMPAIGN_ID \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404


# =============================================================================
# 7. EVENTS ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "7. EVENTS ENDPOINTS"
echo "=========================================="

echo ""
echo "### POST — create event ✅ Happy path (DONOR token)"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Food Distribution Tunis",
    "type": "DISTRIBUTION",
    "description": "Monthly food distribution event",
    "date": "2025-07-15T09:00:00",
    "location": "Place de la Kasbah, Tunis",
    "maxCapacity": 50
  }'
# → Copy returned id into: EVENT_ID="<value>"

echo ""
echo "### POST — create event ✅ VISITE"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Hospital Visit",
    "type": "VISITE",
    "description": "Visit children at hospital",
    "date": "2025-08-01T10:00:00",
    "location": "Hopital d'\''enfants, Tunis",
    "maxCapacity": 20
  }'

echo ""
echo "### POST — create event ✅ FORMATION"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Volunteer Training",
    "type": "FORMATION",
    "description": "Training session for new volunteers",
    "date": "2025-08-10T14:00:00",
    "location": "Community Center",
    "maxCapacity": 30
  }'

echo ""
echo "### POST — create event ✅ COLLECTE"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clothing Collection",
    "type": "COLLECTE",
    "description": "Collect donations of clothing",
    "date": "2025-09-01T09:00:00",
    "location": "City Center",
    "maxCapacity": 100
  }'

echo ""
echo "### POST — create event ❌ CITIZEN tries (403)"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Test", "type": "DISTRIBUTION", "date": "2025-01-01", "maxCapacity": 10 }'
# Expect: 403

echo ""
echo "### POST — create event ❌ Missing title"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "type": "DISTRIBUTION", "date": "2025-01-01", "maxCapacity": 10 }'
# Expect: 400

echo ""
echo "### POST — create event ❌ Missing date"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Test", "type": "DISTRIBUTION", "maxCapacity": 10 }'
# Expect: 400

echo ""
echo "### POST — create event ❌ Missing maxCapacity"
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Test", "type": "DISTRIBUTION", "date": "2025-01-01" }'
# Expect: 400

echo ""
echo "### GET — all events ✅"
curl -X GET http://localhost:8080/api/events \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — single event ✅"
curl -X GET http://localhost:8080/api/events/$EVENT_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — single event ❌ Non-existent"
curl -X GET http://localhost:8080/api/events/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — events by status ✅ UPCOMING"
curl -X GET http://localhost:8080/api/events/status/UPCOMING \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — events by status ✅ ONGOING"
curl -X GET http://localhost:8080/api/events/status/ONGOING \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — events by status ✅ COMPLETED"
curl -X GET http://localhost:8080/api/events/status/COMPLETED \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — events by status ✅ CANCELLED"
curl -X GET http://localhost:8080/api/events/status/CANCELLED \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — events by organizer ✅"
curl -X GET http://localhost:8080/api/events/organizer/$DONOR_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — upcoming events ✅"
curl -X GET http://localhost:8080/api/events/upcoming \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### PUT — update event ✅ Happy path"
curl -X PUT http://localhost:8080/api/events/$EVENT_ID \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Food Distribution Tunis — Updated",
    "type": "DISTRIBUTION",
    "date": "2025-07-15T09:00:00",
    "maxCapacity": 100,
    "description": "Updated description",
    "location": "New Location"
  }'

echo ""
echo "### PUT — update event ❌ Non-owner"
# curl -X PUT http://localhost:8080/api/events/$EVENT_ID \
#   -H "Authorization: Bearer $OTHER_DONOR_TOKEN" \
#   -H "Content-Type: application/json" \
#   -d '{ "title": "Hacked", "type": "DISTRIBUTION", "date": "2025-01-01", "maxCapacity": 10 }'
# Expect: 403

echo ""
echo "### POST — register for event ✅"
curl -X POST http://localhost:8080/api/events/$EVENT_ID/register \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### POST — register for event ❌ No token"
curl -X POST http://localhost:8080/api/events/$EVENT_ID/register
# Expect: 401

echo ""
echo "### POST — register twice ❌ Already registered"
curl -X POST http://localhost:8080/api/events/$EVENT_ID/register \
  -H "Authorization: Bearer $TOKEN"
# Expect: 409

echo ""
echo "### DELETE — cancel registration ✅"
curl -X DELETE http://localhost:8080/api/events/$EVENT_ID/register \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### DELETE — cancel registration ❌ Not registered"
curl -X DELETE http://localhost:8080/api/events/$EVENT_ID/register \
  -H "Authorization: Bearer $TOKEN"
# Expect: 400 or 404

echo ""
echo "### POST — register again for checkin test"
curl -X POST http://localhost:8080/api/events/$EVENT_ID/register \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### POST — check in participant ✅ (Organizer/Admin)"
curl -X POST "http://localhost:8080/api/events/$EVENT_ID/checkin?userId=$USER_ID" \
  -H "Authorization: Bearer $DONOR_TOKEN"

echo ""
echo "### POST — check in participant ❌ Non-organizer"
curl -X POST "http://localhost:8080/api/events/$EVENT_ID/checkin?userId=$USER_ID" \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### POST — confirm attendance ✅"
curl -X POST http://localhost:8080/api/events/$EVENT_ID/attend \
  -H "Authorization: Bearer $TOKEN"
# Expect: 200, attendance recorded, promotion logic triggered

echo ""
echo "### POST — cancel event ✅"
curl -X POST http://localhost:8080/api/events/$EVENT_ID/cancel \
  -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 200, all registrations auto-cancelled

echo ""
echo "### DELETE — delete event ✅"
# Create a temp event first
curl -X POST http://localhost:8080/api/events \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Temp Event", "type": "VISITE", "date": "2025-12-01T10:00:00", "maxCapacity": 10 }'
# Then delete: curl -X DELETE http://localhost:8080/api/events/{id} -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 204

echo ""
echo "### DELETE — delete event ❌ Non-owner"
curl -X DELETE http://localhost:8080/api/events/1 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### GET — confirm deletion"
curl -X GET http://localhost:8080/api/events/$EVENT_ID \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404


# =============================================================================
# 8. PROJECTS ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "8. PROJECTS ENDPOINTS"
echo "=========================================="

echo ""
echo "### POST — create project ✅ Happy path (DONOR token)"
curl -X POST http://localhost:8080/api/projects \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Solar Panels for Schools",
    "description": "Install solar panels in 5 rural schools",
    "goalAmount": 20000.00,
    "organizerType": "DONOR"
  }'
# → Copy returned id into: PROJECT_ID="<value>"

echo ""
echo "### POST — create project ❌ CITIZEN tries (403)"
curl -X POST http://localhost:8080/api/projects \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Test", "goalAmount": 1000 }'
# Expect: 403

echo ""
echo "### POST — create project ❌ Missing title"
curl -X POST http://localhost:8080/api/projects \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "goalAmount": 1000 }'
# Expect: 400

echo ""
echo "### POST — create project ❌ Missing goalAmount"
curl -X POST http://localhost:8080/api/projects \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Test Project" }'
# Expect: 400

echo ""
echo "### GET — all projects ✅"
curl -X GET http://localhost:8080/api/projects \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — single project ✅"
curl -X GET http://localhost:8080/api/projects/$PROJECT_ID \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — single project ❌ Non-existent"
curl -X GET http://localhost:8080/api/projects/99999 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404

echo ""
echo "### GET — projects by status ✅"
curl -X GET http://localhost:8080/api/projects/status/ACTIVE \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### PUT — update project ✅ Happy path"
curl -X PUT http://localhost:8080/api/projects/$PROJECT_ID \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Solar Panels for Schools — Phase 2",
    "description": "Updated description",
    "goalAmount": 25000.00
  }'

echo ""
echo "### PUT — update project ❌ Non-owner"
# curl -X PUT http://localhost:8080/api/projects/$PROJECT_ID \
#   -H "Authorization: Bearer $OTHER_DONOR_TOKEN" \
#   -H "Content-Type: application/json" \
#   -d '{ "title": "Hacked", "goalAmount": 1000 }'
# Expect: 403

echo ""
echo "### POST — vote on project ✅"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/vote \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### POST — vote on project ❌ No token"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/vote
# Expect: 401

echo ""
echo "### POST — vote twice ❌ Already voted"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/vote \
  -H "Authorization: Bearer $TOKEN"
# Expect: 409

echo ""
echo "### POST — fund project ✅"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/fund \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "projectId": 1,
    "amount": 500.00,
    "paymentMethod": "CREDIT_CARD"
  }'
# → Copy returned funding id if available

echo ""
echo "### POST — fund project ❌ No token"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/fund \
  -H "Content-Type: application/json" \
  -d '{ "projectId": 1, "amount": 500.00 }'
# Expect: 401

echo ""
echo "### POST — fund project ❌ Negative amount"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/fund \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "projectId": 1, "amount": -100.00 }'
# Expect: 400

echo ""
echo "### POST — fund project ❌ Missing amount"
curl -X POST http://localhost:8080/api/projects/$PROJECT_ID/fund \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "projectId": 1 }'
# Expect: 400

echo ""
echo "### POST — complete project ✅"
curl -X POST "http://localhost:8080/api/projects/$PROJECT_ID/complete?finalReport=Project completed successfully. All solar panels installed." \
  -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 200, status = COMPLETED

echo ""
echo "### POST — complete project ❌ Non-owner"
curl -X POST "http://localhost:8080/api/projects/$PROJECT_ID/complete?finalReport=test" \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### DELETE — delete project ✅"
# Create a temp project first
curl -X POST http://localhost:8080/api/projects \
  -H "Authorization: Bearer $DONOR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "title": "Temp Project", "goalAmount": 1000 }'
# Then delete: curl -X DELETE http://localhost:8080/api/projects/{id} -H "Authorization: Bearer $DONOR_TOKEN"
# Expect: 204

echo ""
echo "### DELETE — delete project ❌ Non-owner"
curl -X DELETE http://localhost:8080/api/projects/1 \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403

echo ""
echo "### GET — confirm deletion"
curl -X GET http://localhost:8080/api/projects/$PROJECT_ID \
  -H "Authorization: Bearer $TOKEN"
# Expect: 404


# =============================================================================
# 9. IMPACT METRICS ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "9. IMPACT METRICS ENDPOINTS"
echo "=========================================="

echo ""
echo "### GET — metrics by date ✅"
curl -X GET http://localhost:8080/api/metrics/date/2025-01-01 \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — metrics between dates ✅"
curl -X GET "http://localhost:8080/api/metrics/range?startDate=2025-01-01&endDate=2025-12-31" \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — daily metrics ✅"
curl -X GET http://localhost:8080/api/metrics/daily \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — daily metrics ❌ No token"
curl -X GET http://localhost:8080/api/metrics/daily
# Expect: 401

echo ""
echo "### GET — monthly metrics ✅"
curl -X GET http://localhost:8080/api/metrics/monthly \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — yearly metrics ✅"
curl -X GET http://localhost:8080/api/metrics/yearly \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### POST — recalculate metrics (ADMIN only) ✅"
curl -X POST http://localhost:8080/api/metrics/recalculate \
  -H "Authorization: Bearer $ADMIN_TOKEN"

echo ""
echo "### POST — recalculate metrics ❌ Non-admin"
curl -X POST http://localhost:8080/api/metrics/recalculate \
  -H "Authorization: Bearer $TOKEN"
# Expect: 403


# =============================================================================
# 10. ADMIN ENDPOINTS
# =============================================================================

echo ""
echo "=========================================="
echo "10. ADMIN ENDPOINTS"
echo "=========================================="

echo ""
echo "### GET — dashboard stats (authenticated) ✅"
curl -X GET http://localhost:8080/api/admin/dashboard \
  -H "Authorization: Bearer $TOKEN"

echo ""
echo "### GET — dashboard stats ❌ No token"
curl -X GET http://localhost:8080/api/admin/dashboard
# Expect: 401

echo ""
echo "### GET — dashboard stats (any authenticated user)"
curl -X GET http://localhost:8080/api/admin/dashboard \
  -H "Authorization: Bearer $DONOR_TOKEN"


# =============================================================================
# 11. PDF ENDPOINTS (ADMIN only)
# =============================================================================

echo ""
echo "=========================================="
echo "11. PDF ENDPOINTS (ADMIN only)"
echo "=========================================="

echo ""
echo "### GET — campaign PDF report ✅"
curl -X GET http://localhost:8080/api/pdf/campaigns/$CAMPAIGN_ID \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  --output campaign_report.pdf

echo ""
echo "### GET — campaign PDF report ❌ Non-admin"
curl -X GET http://localhost:8080/api/pdf/campaigns/$CAMPAIGN_ID \
  -H "Authorization: Bearer $TOKEN" \
  --output campaign_report_fail.pdf
# Expect: 403

echo ""
echo "### GET — project PDF report ✅"
curl -X GET http://localhost:8080/api/pdf/projects/$PROJECT_ID \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  --output project_report.pdf

echo ""
echo "### GET — project PDF report ❌ Non-admin"
curl -X GET http://localhost:8080/api/pdf/projects/$PROJECT_ID \
  -H "Authorization: Bearer $TOKEN" \
  --output project_report_fail.pdf
# Expect: 403

echo ""
echo "### GET — metrics PDF report ✅"
curl -X GET http://localhost:8080/api/pdf/metrics \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  --output metrics_report.pdf

echo ""
echo "### GET — metrics PDF report ❌ Non-admin"
curl -X GET http://localhost:8080/api/pdf/metrics \
  -H "Authorization: Bearer $TOKEN" \
  --output metrics_report_fail.pdf
# Expect: 403


echo ""
echo "=========================================="
echo "ALL TEST SCENARIOS COMPLETED"
echo "=========================================="
