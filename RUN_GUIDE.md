# Bakery Order and Custom Cake Booking Platform - Run Guide

## Architecture

This is a **single integrated application**:

- **Backend**: Spring Boot (Java) running on port 8080
- **Frontend**: JSP views served by embedded Tomcat (no separate frontend server needed)
- **Database**: H2 in-memory database (development mode)

---

## Prerequisites

- Java 17+ installed
- Maven 3.6+ installed
- Terminal/Command Prompt

---

## How to Run

### 1. **Start the Application**

From the project root directory, run:

```bash
mvn spring-boot:run
```

**Expected output:**

```
Started BakeryApplication in 1.315 seconds
Tomcat started on port(s): 8080 (http) with context path ''
Test Data Loaded Successfully!
```

### 2. **Access the Application**

Open your browser and go to:

```
http://localhost:8080
```

### 3. **Available Pages**

The application automatically loads test data. You can access:

| Page                | URL                                   | Purpose                 |
| ------------------- | ------------------------------------- | ----------------------- |
| Home/Dashboard      | `http://localhost:8080`               | Main landing page       |
| Orders List         | `http://localhost:8080/orders`        | View all orders         |
| Custom Orders       | `http://localhost:8080/custom-orders` | View custom cake orders |
| Order History       | `http://localhost:8080/history`       | View order history      |
| Checkout            | `http://localhost:8080/checkout`      | Checkout page           |
| H2 Database Console | `http://localhost:8080/h2-console`    | View/manage database    |

---

## Database Access (Optional)

### H2 Console

To view the in-memory database:

1. Go to: `http://localhost:8080/h2-console`
2. Keep default settings (JDBC URL: `jdbc:h2:mem:bakery_db`)
3. Click **Connect**

You'll see tables:

- `orders` - All orders
- `standard_order` - Standard bakery products
- `custom_order` - Custom cake orders

---

## Build Only (Without Running)

To compile the project without starting the server:

```bash
mvn clean package
```

This creates a WAR file in `target/bakery-app.war` that can be deployed to any Java web server.

---

## Stop the Application

Press `Ctrl+C` in the terminal where the app is running.

---

## Troubleshooting

### Port 8080 Already in Use

If port 8080 is busy, change it in `src/main/resources/application.properties`:

```properties
server.port=9090
```

Then access: `http://localhost:9090`

### Application Won't Start

1. Ensure Java 17+ is installed: `java -version`
2. Ensure Maven is installed: `mvn -version`
3. Clear Maven cache: `mvn clean`
4. Rebuild: `mvn spring-boot:run`

### Database Issues

The H2 in-memory database resets when the app stops. To persist data, switch to MySQL (update `application.properties`).

---

## Project Structure

```
Bakery-Order-and-Custom-Cake-Booking-Platform/
├── pom.xml                      # Maven configuration (dependencies)
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/bakery/project/
│   │   │       ├── BakeryApplication.java    # Main Spring Boot app
│   │   │       ├── controller/               # REST endpoints
│   │   │       ├── model/                    # Entity classes
│   │   │       ├── repository/               # Database access
│   │   │       └── service/                  # Business logic
│   │   ├── resources/
│   │   │   └── application.properties        # App configuration
│   │   └── webapp/
│   │       └── views/                        # JSP frontend pages
│   └── test/                                 # Tests (optional)
└── target/                                   # Compiled output
```

---

## Next Steps

1. **Understand the flow**: When you visit `http://localhost:8080`, the request goes to the Spring Boot controller, which processes it and returns a JSP view
2. **Modify controllers**: Edit files in `src/main/java/com/bakery/project/controller/`
3. **Modify frontend**: Edit JSP files in `src/main/webapp/views/`
4. **Restart**: Stop (Ctrl+C) and run `mvn spring-boot:run` again to see changes

---

## Key Files to Know

| File                                                   | Purpose                          |
| ------------------------------------------------------ | -------------------------------- |
| `pom.xml`                                              | Dependencies & build config      |
| `BakeryApplication.java`                               | Entry point of application       |
| `OrderController.java`                                 | Handles order-related requests   |
| `OrderService.java`                                    | Business logic for orders        |
| `Order.java`, `StandardOrder.java`, `CustomOrder.java` | Database entity classes          |
| `application.properties`                               | Database, server, logging config |
