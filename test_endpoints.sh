#!/bin/bash

# Bakery Application - Endpoint Testing Script
# This script tests all API endpoints to verify the backend is working correctly

BASE_URL="http://localhost:8080"
PASSED=0
FAILED=0
TOTAL=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print test header
print_header() {
    echo -e "\n${BLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC} $1"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${NC}"
}

# Function to test GET endpoint
test_get() {
    local endpoint=$1
    local description=$2
    TOTAL=$((TOTAL + 1))
    
    echo -e "\n${YELLOW}[Test $TOTAL]${NC} GET $endpoint"
    echo "Description: $description"
    
    http_code=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL$endpoint")
    
    if [[ $http_code == "200" ]] || [[ $http_code == "302" ]]; then
        echo -e "${GREEN}✓ PASS${NC} - HTTP $http_code"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC} - HTTP $http_code"
        FAILED=$((FAILED + 1))
    fi
}

# Function to test POST endpoint
test_post() {
    local endpoint=$1
    local description=$2
    local data=$3
    TOTAL=$((TOTAL + 1))
    
    echo -e "\n${YELLOW}[Test $TOTAL]${NC} POST $endpoint"
    echo "Description: $description"
    
    http_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$BASE_URL$endpoint" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "$data")
    
    if [[ $http_code == "200" ]] || [[ $http_code == "302" ]] || [[ $http_code == "201" ]]; then
        echo -e "${GREEN}✓ PASS${NC} - HTTP $http_code"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC} - HTTP $http_code"
        FAILED=$((FAILED + 1))
    fi
}

# Start testing
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║   Bakery Order & Custom Cake Booking Platform - API Tests      ║"
echo "║   Base URL: $BASE_URL"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if server is running
echo -e "\n${YELLOW}Checking if server is running...${NC}"
if ! curl -s "$BASE_URL" > /dev/null 2>&1; then
    echo -e "${RED}✗ ERROR: Server is not running at $BASE_URL${NC}"
    echo -e "${YELLOW}Start the server with: mvn -DskipTests spring-boot:run${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Server is running${NC}"

# ============================================================================
# STANDARD ORDERS TESTS
# ============================================================================
print_header "STANDARD ORDERS ENDPOINTS"

test_get "/orders" "Get orders (redirect to history)"
test_get "/orders/history" "Get all orders history"

test_post "/orders/place" "Place a standard order" \
    "customerName=John%20Doe&status=Pending&totalAmount=45.50"

# ============================================================================
# CUSTOM ORDERS TESTS
# ============================================================================
print_header "CUSTOM ORDERS ENDPOINTS"

test_get "/custom-orders" "List all custom orders"
test_get "/custom-orders/new" "Get custom order form"

test_post "/custom-orders/place" "Place a custom order" \
    "customerName=Jane%20Smith&status=In%20Progress&totalAmount=125.00&flavor=Chocolate&cakeSize=Medium&layers=3&complexity=High&cakeDesign=Modern%20Geometric&specialInstructions=Add%20gold%20leaf&deliveryDate=2026-05-25&urgency=Normal"

# Test edit form (using order ID 1 - should exist from test data)
test_get "/custom-orders/edit/1" "Get custom order edit form (ID: 1)"

# Test track (using order ID 1)
test_get "/custom-orders/track/1" "Track custom order (ID: 1)"

# Test update (using order ID 1)
test_post "/custom-orders/update/1" "Update custom order (ID: 1)" \
    "customerName=Jane%20Smith&status=Completed&totalAmount=150.00&flavor=Vanilla&cakeSize=Large&layers=4&complexity=Very%20High&cakeDesign=Custom%20Art&specialInstructions=Extra%20decoration&deliveryDate=2026-06-10&urgency=High"

# Test delete (note: uses a high ID to avoid deleting test data)
test_post "/custom-orders/delete/999" "Delete custom order (ID: 999 - may not exist)" \
    ""

# ============================================================================
# ADMIN ENDPOINTS
# ============================================================================
print_header "ADMIN ENDPOINTS"

test_get "/admin-dashboard" "Get admin dashboard"

# ============================================================================
# DATABASE ENDPOINTS
# ============================================================================
print_header "DATABASE ENDPOINTS"

test_get "/h2-console" "Access H2 database console"

# ============================================================================
# SUMMARY
# ============================================================================
print_header "TEST SUMMARY"

echo -e "\n${BLUE}Total Tests:${NC}  $TOTAL"
echo -e "${GREEN}Passed:${NC}       $PASSED"
echo -e "${RED}Failed:${NC}       $FAILED"

# Calculate percentage
if [[ $TOTAL -gt 0 ]]; then
    PERCENTAGE=$((PASSED * 100 / TOTAL))
    echo -e "${BLUE}Success Rate:${NC} $PERCENTAGE%"
fi

echo ""

# Exit with appropriate code
if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All tests passed! Backend is working correctly.${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Check the output above for details.${NC}"
    exit 1
fi
