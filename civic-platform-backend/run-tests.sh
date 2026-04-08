#!/bin/bash
# API Test Results - Civic Platform Backend
# Date: $(date)
# Base URL: http://localhost:8081/api

echo "=============================================="
echo "API ENDPOINT TEST RESULTS"
echo "=============================================="
echo ""

# Test 1: Auth Register CITIZEN
echo "1. POST /api/auth/register (CITIZEN)"
RESULT=$(curl -s -X POST http://localhost:8081/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"userType": "CITIZEN", "firstName": "Aymen", "lastName": "Ben Ali", "userName": "aymen123", "email": "aymen@test.com", "password": "Test1234!", "phone": "55123456", "address": "12 Rue de Tunis", "birthDate": "1998-05-15"}' \
  -w "\nHTTP_STATUS: %{http_code}\n")
echo "$RESULT"
echo "---"
