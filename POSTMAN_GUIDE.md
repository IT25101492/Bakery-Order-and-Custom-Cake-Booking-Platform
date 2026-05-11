# Bakery API - Postman Collection Guide

## Overview

This Postman collection provides comprehensive testing for the **Bakery Order & Custom Cake Booking Platform** backend API. All 12 endpoints have been tested and verified to work correctly.

## Quick Start

### 1. Import the Collection

- Open **Postman**
- Click **File** → **Import**
- Select `Bakery_API_Collection.postman_collection.json`
- Click **Import**

### 2. Configure Environment

Before making requests, set the base URL:

1. Click **Environments** (top-right dropdown)
2. Create a new environment or use default
3. Set variable: `base_url` = `http://localhost:8080`
   - Change to `http://localhost:9090` if running on port 9090

### 3. Start the Backend Server

```bash
mvn -DskipTests spring-boot:run
```

Server will start at `http://localhost:8080` (or configured port)

### 4. Run Requests

- Select the environment with correct `base_url`
- Click any request and hit **Send**
- View response in the response panel

---

## API Endpoints Overview

### 📦 Standard Orders (3 endpoints)

| Method | Endpoint          | Purpose                    |
| ------ | ----------------- | -------------------------- |
| GET    | `/orders`         | Redirect to orders history |
| GET    | `/orders/history` | Get all standard orders    |
| POST   | `/orders/place`   | Create new standard order  |

**Sample Request Body** (POST /orders/place):

```
customerName=John Doe
status=Pending
totalAmount=45.50
productCategory=Bread
```

---

### 🎂 Custom Orders (7 endpoints)

| Method | Endpoint                     | Purpose                      |
| ------ | ---------------------------- | ---------------------------- |
| GET    | `/custom-orders`             | List all custom orders       |
| GET    | `/custom-orders/new`         | Get custom order form (HTML) |
| POST   | `/custom-orders/place`       | Create new custom order      |
| GET    | `/custom-orders/edit/{id}`   | Get edit form for order      |
| POST   | `/custom-orders/update/{id}` | Update custom order          |
| GET    | `/custom-orders/track/{id}`  | Track order status           |
| POST   | `/custom-orders/delete/{id}` | Delete custom order          |

**Sample Request Body** (POST /custom-orders/place):

```
customerName=Jane Smith
status=In Progress
totalAmount=125.00
flavor=Chocolate
cakeSize=Medium
layers=3
complexity=High
cakeDesign=Modern Geometric
specialInstructions=Add gold leaf decoration
deliveryDate=2026-05-25
urgency=Normal
```

---

### 👨‍💼 Admin (1 endpoint)

| Method | Endpoint           | Purpose                              |
| ------ | ------------------ | ------------------------------------ |
| GET    | `/admin-dashboard` | View admin dashboard with all orders |

---

### 🗄️ Database (1 endpoint)

| Method | Endpoint      | Purpose                              |
| ------ | ------------- | ------------------------------------ |
| GET    | `/h2-console` | Access H2 in-memory database console |

---

## Field Descriptions

### Standard Order Fields

| Field             | Type   | Description                                         |
| ----------------- | ------ | --------------------------------------------------- |
| `customerName`    | String | Name of the customer                                |
| `status`          | String | Order status (Pending, Confirmed, Ready, Delivered) |
| `totalAmount`     | Double | Total price of the order                            |
| `productCategory` | String | Category (Bread, Pastry, Cake, etc.)                |

### Custom Order Fields

| Field                 | Type    | Description                                      |
| --------------------- | ------- | ------------------------------------------------ |
| `customerName`        | String  | Name of the customer                             |
| `status`              | String  | Order status (In Progress, Completed, Cancelled) |
| `totalAmount`         | Double  | Total price of the custom cake                   |
| `flavor`              | String  | Cake flavor (Chocolate, Vanilla, etc.)           |
| `cakeSize`            | String  | Size (Small, Medium, Large)                      |
| `layers`              | Integer | Number of cake layers                            |
| `complexity`          | String  | Complexity level (Low, Medium, High, Very High)  |
| `cakeDesign`          | String  | Design description                               |
| `specialInstructions` | String  | Special requests or notes                        |
| `deliveryDate`        | String  | Delivery date (YYYY-MM-DD format)                |
| `urgency`             | String  | Urgency level (Normal, High)                     |

---

## Testing Checklist

✅ All endpoints verified with **100% success rate**

Run automated tests with:

```bash
./test_endpoints.sh
```

Expected output:

```
Total Tests:    12
Passed:         12
Failed:         0
Success Rate:   100%
```

---

## Common Issues & Solutions

### "Server is not running"

**Problem:** Connection refused error
**Solution:** Start the server first

```bash
mvn -DskipTests spring-boot:run
```

### "404 Not Found" on GET requests

**Problem:** Endpoint doesn't exist
**Solution:** Verify the server is running and check endpoint URL spelling

### "400 Bad Request" on POST requests

**Problem:** Missing or incorrect form fields
**Solution:** Check field names match exactly (case-sensitive):

- Use `flavor` not `cakeFlavor`
- Use `cakeSize` not `size`

### "500 Internal Server Error"

**Problem:** Server error during request processing
**Solution:** Check server logs for detailed error message

---

## Database Access

### H2 Console

Access the in-memory database:

1. Go to: `http://localhost:8080/h2-console`
2. JDBC URL: `jdbc:h2:mem:bakery_db`
3. Username: `sa`
4. Password: (leave empty)
5. Click **Connect**

**Available Tables:**

- `orders` - All orders (standard + custom)
- `standard_order` - Standard bakery orders
- `custom_order` - Custom cake orders

---

## Tips & Tricks

### Use Collection Variables

Replace order IDs in edit/track/delete endpoints:

- Change `/custom-orders/edit/1` to `/custom-orders/edit/{your_id}`
- Get IDs from previous GET responses

### Test Data

The app loads sample data on startup:

- 1 standard order
- 1 custom order

### Modify Sample Data

Edit request body fields before sending to test different scenarios:

- Change `status` to test different order statuses
- Change `layers`, `complexity`, etc. for different cake types

### Response Headers

All successful redirects (302) return a `Location` header showing the next page

---

## Next Steps

1. ✅ Import collection
2. ✅ Set environment variable
3. ✅ Start backend server
4. ✅ Run first GET request (e.g., `/orders/history`)
5. ✅ Test POST request (e.g., `/custom-orders/place`)
6. ✅ Check database via H2 Console

---

## Support

For issues or questions:

- Check server logs: Look at Maven console output
- Verify field names: Use exact names from field descriptions
- Review sample data: Adjust request bodies as needed
- Run test script: `./test_endpoints.sh` for full validation

---

**Last Updated:** May 9, 2026  
**API Status:** ✅ All endpoints operational  
**Test Coverage:** 100% (12/12 endpoints tested)
