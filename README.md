# Spring Boot CRUD Base Project

## 🚀 Java Eats 

### Prerequisites
- Java 17+
- Maven 3.6+
- Docker 

### Installation
```bash
 git clone https://github.com/AHMEDSAEEDGIT/java-eats.git
 cd spring-crud-base
 mvn spring-boot:run
```
### API Documentation
- Swagger UI: http://localhost:8080/swagger-ui.html
- Health Check: http://localhost:8080/actuator/health

---

## 🏗️ Project Architecture Guide

### 📁 Directory Structure Explained

```text
src/main/java/com/food-delivery/javaeats/
├── controller/         # REST API endpoints
├── service/            # Business logic layer  
|   └── impl/           # service implementation
├── repository/         # Data access layer (Spring Data JPA)
├── model/              # Database entities and enums
├── dto/                # Data Transfer Objects
│   ├── request/        # API request objects
│   └── response/       # API response objects
├── exception/          # Exception handling
│   ├── custom/         # Custom exceptions
│   └── handler/        # Global exception handlers
├── security/           # security classes
├── config/             # Spring configuration classes
└── util/               # Utility classes and helpers
```

### 🔧 Layer-by-Layer Explanation

#### 1. Controller Layer (controller/)
- **Purpose**: Handle HTTP requests/responses
- **Responsibilities**: API endpoint definitions, Request validation, Response formatting


#### 2. Service Layer (service/)
- **Purpose**: Business logic implementation
- **Responsibilities**: Business rules validation, Transaction management, Orchestrating repository calls

#### 3. Repository Layer (repository/)
- **Purpose**: Data access operations
- **Responsibilities**: Database interactions, Custom queries, Data persistence

#### 4. Model Layer (model/)
- **Purpose**: Database entity definitions
- **Responsibilities**: JPA entity mappings, Database relationships, Enum definitions

### 📊 DTO Pattern (dto/)

#### Request DTOs (dto/request/)
- **Purpose**: Validate and encapsulate API input

#### Response DTOs (dto/response/)
- **Purpose**: Format API output consistently

### ⚠️ Exception Handling (exception/)

#### Custom Exceptions (exception/custom/)
```java
 public class NotFoundException extends RuntimeException {
     public NotFoundException(String resourceName, Long id) {
         super(resourceName + " with id " + id + " not found");
     }
 }
 public class ValidationException extends RuntimeException {
     public ValidationException(String message) {
         super(message);
     }
 }
 public class BusinessException extends RuntimeException {
     public BusinessException(String message) {
         super(message);
     }
 }
```
#### Global Exception Handler (exception/handler/)
```java
 @ControllerAdvice
 public class GlobalExceptionHandler {
     
     @ExceptionHandler(NotFoundException.class)
     public ResponseEntity<ErrorResponse> handleNotFound(NotFoundException ex) {
         ErrorResponse error = new ErrorResponse("NOT_FOUND", ex.getMessage());
         return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
     }
     
     @ExceptionHandler(ValidationException.class)
     public ResponseEntity<ErrorResponse> handleValidation(ValidationException ex) {
         ErrorResponse error = new ErrorResponse("VALIDATION_ERROR", ex.getMessage());
         return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
     }
 }
```
### ⚙️ Configuration (config/)
- **Purpose**: Spring configuration classes
- **Examples**: SwaggerConfig, SecurityConfig, DatabaseConfig
- **Example Usage**:
```java
 @Configuration
 @OpenAPIDefinition(info = @Info(title = "API Documentation", version = "1.0"))
 public class SwaggerConfig {
     @Bean
     public OpenAPI customOpenAPI() {
         return new OpenAPI().info(new Info().title("CRUD API").version("1.0"));
     }
 }
```
### 🔧 Utilities (util/)
- **Purpose**: Helper classes and constants
- **Examples**: ValidationUtils, DateUtils, Constants
- **Example Usage**:
```java
 public final class Constants {
     public static final int MAX_PAGE_SIZE = 100;
     public static final String DEFAULT_TIMEZONE = "UTC";
     private Constants() {} // Prevent instantiation
 }
```
---

## 🐳 Docker Support

### Running with Docker:
```bash
 docker-compose up -d
```
### Docker Structure:
- Dockerfile - Application container definition
- docker-compose.yml - Multi-service setup (app + database)
- docker/ - Additional Docker configurations

---

## 📚 Development Guidelines

### Code Standards
- Follow Java naming conventions (camelCase for variables/methods, PascalCase for classes)
- Use meaningful class/method names
- Add Javadoc for public methods
- Write unit tests for service layer (optional)

### API Design Principles
- Use RESTful principles with resource-based URLs
- Consistent endpoint naming (/api/v1/users, /api/v1/products)
- Proper HTTP status codes (200 OK, 201 Created, 400 Bad Request, 404 Not Found)
- Standardized error responses with error code and message

### Branch Strategy
- main - Production-ready code (protected)
- develop - Development integration branch
- Feature branches: feature/user-management, feature/payment-integration
- Hotfix branches: hotfix/critical-bug-fix

---

## 🛠️ Common Tasks

### Adding a New Entity (Example: Product)
1. Create Product entity in model/
> @Entity
> public class Product { ... }

2. Create ProductRepository in repository/
> public interface ProductRepository extends JpaRepository<Product, Long> { ... }

3. Create ProductService in service/
> @Service
> public class ProductService { ... }

4. Create ProductController in controller/
> @RestController
> public class ProductController { ... }

5. Add request/response DTOs in dto/request/ and dto/response/
6. Create migration script in db/migrations/

### Adding Custom Exception
1. Create exception in exception/custom/
> public class ProductNotFoundException extends NotFoundException { ... }

2. Add handler method in exception/handler/GlobalExceptionHandler
> @ExceptionHandler(ProductNotFoundException.class)
> public ResponseEntity<ErrorResponse> handleProductNotFound(ProductNotFoundException ex) { ... }

3. Use in service layer
> public Product findById(Long id) {
>     return productRepository.findById(id)
>         .orElseThrow(() -> new ProductNotFoundException(id));
> }

---

## 📋 Project Conventions

### Naming Conventions
- Controllers: UserController, ProductController
- Services: UserService, ProductService (interface) + UserServiceImpl (implementation if needed)
- Repositories: UserRepository, ProductRepository
- Models: User, Product (singular nouns)
- DTOs: UserRequest, UserResponse or CreateUserRequest, UpdateUserRequest

### Package Structure Best Practices
- Keep related classes together
- Use subpackages for better organization (dto/request/, dto/response/)
- Avoid circular dependencies between packages
- Put shared utilities in common packages

### Testing Structure
- Unit tests for services and utilities
- Integration tests for repositories
- API tests for controllers
- Test classes should mirror main structure (UserServiceTest, UserControllerTest)

---

### Common Issues and Solutions
- Database connection issues: Check application.yml configuration
- Migration failures: Verify SQL script syntax and naming
- Dependency conflicts: Use Maven dependency tree to resolve
- Bean creation errors: Check component scanning and annotations


