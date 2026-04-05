# Civic Engagement Platform

A comprehensive full-stack platform for managing civic engagement, including users, campaigns, events, projects, and impact metrics.

## 🏗️ Project Structure

```
PI-CIS/
├── civic-platform-backend/          # Spring Boot Backend
│   ├── src/main/java/com/civicplatform/
│   │   ├── controller/           # REST Controllers
│   │   ├── service/              # Business Logic
│   │   ├── repository/           # Data Access Layer
│   │   ├── entity/              # JPA Entities
│   │   ├── dto/                 # Data Transfer Objects
│   │   ├── mapper/              # MapStruct Mappers
│   │   ├── security/            # JWT Authentication
│   │   ├── validator/           # Custom Validators
│   │   └── exception/          # Exception Handling
│   └── src/main/resources/
│       ├── application.yml       # Configuration
│       └── templates/email/     # Email Templates
└── civic-platform-frontend/         # Angular Frontend
    ├── src/app/
    │   ├── core/               # Core Services & Auth
    │   ├── features/           # Feature Modules
    │   └── shared/            # Shared Components
    ├── package.json
    └── angular.json
```

## 🛠️ Technology Stack

### Backend
- **Spring Boot 3.2.3** - Main framework
- **Java 17+** - Programming language
- **Spring Security 6** - Authentication & Authorization
- **JWT (jjwt 0.12.5)** - Token-based authentication
- **Spring Data JPA + Hibernate** - Database ORM
- **MariaDB** - Relational database
- **MapStruct** - DTO mapping
- **Bean Validation** - Input validation
- **Apache PDFBox** - PDF generation
- **Spring Mail + Thymeleaf** - Email services
- **Lombok** - Code generation
- **SpringDoc OpenAPI** - API documentation

### Frontend
- **Angular 17+** - Frontend framework
- **TypeScript** - Type-safe JavaScript
- **TailwindCSS** - Utility-first CSS framework
- **RxJS** - Reactive programming
- **Angular Router** - Client-side routing
- **Angular Forms** - Form handling

## 🚀 Getting Started

### Prerequisites
- Java 17+
- Node.js 18+
- MariaDB
- Maven
- Angular CLI

### Backend Setup

1. **Database Setup:**
   ```sql
   CREATE DATABASE civic_platform;
   ```

2. **Configure Application:**
   Update `civic-platform-backend/src/main/resources/application.yml` with your database credentials:
   ```yaml
   spring:
     datasource:
       url: jdbc:mariadb://localhost:3306/civic_platform
       username: your_username
       password: your_password
   ```

3. **Run Backend:**
   ```bash
   cd civic-platform-backend
   mvn spring-boot:run
   ```

4. **Access API Documentation:**
   Open http://localhost:8080/swagger-ui.html in your browser

### Frontend Setup

1. **Install Dependencies:**
   ```bash
   cd civic-platform-frontend
   npm install
   ```

2. **Run Development Server:**
   ```bash
   npm start
   ```

3. **Access Application:**
   Open http://localhost:4200 in your browser

## 📋 Key Features

### 🔐 Authentication & Authorization
- JWT-based authentication with refresh tokens
- Role-based access control (ADMIN, MODERATOR, USER)
- Multiple user types: Ambassador, Donor, Citizen, Participant
- Custom validation for user registration

### 👥 User Management
- Complete CRUD operations
- User type-specific fields
- Ambassador promotion logic
- Profile management

### 📊 Campaign Management
- Create, launch, and manage campaigns
- Voting system for campaign activation (100 votes threshold)
- Progress tracking (kg, meals, funding)
- Status management (DRAFT, ACTIVE, COMPLETED, CANCELLED)

### 📅 Event Management
- Event creation and management
- Registration with capacity limits
- Check-in functionality
- Event status tracking

### 💼 Project Management
- Project creation and funding
- Vote tracking
- Progress monitoring
- Completion reports

### 📈 Impact Metrics
- Automated daily metrics calculation
- CO₂ savings tracking
- Meals distribution metrics
- PDF report generation

### 📧 Advanced Features
- **PDF Generation**: Campaign, project, and metrics reports
- **Email Notifications**: Registration, campaign launches, event confirmations
- **Scheduled Jobs**: Daily metrics calculation
- **Role-based UI**: Different interfaces for different user types

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `POST /api/auth/refresh` - Token refresh
- `POST /api/auth/logout` - User logout

### Users
- `GET /api/users` - Get all users (Admin)
- `GET /api/users/{id}` - Get user by ID
- `PUT /api/users/{id}` - Update user
- `DELETE /api/users/{id}` - Delete user (Admin)
- `POST /api/users/{id}/promote` - Promote to ambassador (Admin)

### Campaigns
- `GET /api/campaigns` - Get all campaigns
- `POST /api/campaigns` - Create campaign
- `POST /api/campaigns/{id}/launch` - Launch campaign
- `POST /api/campaigns/{id}/vote` - Vote for campaign

### Events
- `GET /api/events` - Get all events
- `POST /api/events` - Create event
- `POST /api/events/{id}/register` - Register for event
- `POST /api/events/{id}/checkin` - Check-in participant

### Projects
- `GET /api/projects` - Get all projects
- `POST /api/projects` - Create project
- `POST /api/projects/{id}/fund` - Fund project
- `POST /api/projects/{id}/vote` - Vote for project

### Metrics
- `GET /api/metrics/daily` - Get daily metrics
- `GET /api/metrics/monthly` - Get monthly metrics
- `GET /api/pdf/metrics` - Export metrics PDF

## 🎯 User Types & Roles

### User Types
- **AMBASSADOR**: Community leaders with badges
- **DONOR**: Organizations providing resources
- **CITIZEN**: Regular community members
- **PARTICIPANT**: Event participants with points

### Roles
- **ADMIN**: Full system access
- **MODERATOR**: Content moderation
- **USER**: Standard user access

## 📧 Development

### Backend Development
```bash
# Build
mvn clean install

# Run tests
mvn test

# Run with specific profile
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

### Frontend Development
```bash
# Build for production
npm run build

# Run tests
npm test

# Lint code
npm run lint
```

## 🔧 Configuration

### Environment Variables
- `DB_PASSWORD`: MariaDB password
- `JWT_SECRET`: JWT signing secret
- `MAIL_USERNAME`: Email username
- `MAIL_PASSWORD`: Email password
- `CORS_ALLOWED_ORIGINS`: Allowed CORS origins

### Database Schema
The application uses JPA/Hibernate with `ddl-auto: update` for development. The schema includes:
- Users with type-specific fields
- Campaigns with voting and progress tracking
- Events with registration management
- Projects with funding tracking
- Posts with comments and likes
- Impact metrics with automated calculation

## 📧 Production Deployment

### Backend
1. Set up MariaDB server
2. Configure production properties
3. Build JAR: `mvn clean package`
4. Deploy to server with: `java -jar target/civic-platform-backend-1.0.0.jar`

### Frontend
1. Build for production: `npm run build`
2. Deploy dist/ folder to web server
3. Configure web server for SPA routing

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open Pull Request

## 📄 License

This project is licensed under the ISC License.

## 📞 Support

For support and questions, please open an issue in the repository.
