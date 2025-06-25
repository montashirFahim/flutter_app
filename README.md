# Lii Lab Mobile Developer Assessment

This is a Flutter application. The app implements an authentication flow (login, signup, forgot password) and a feed screen where users can view, create, like, and comment on posts. The backend is simulated using mock data and in-memory repositories.

## Features
- **Authentication**:
  - Log in with email and password
  - Sign up with name, username, email, password, date of birth, and gender
  - Forgot password functionality with mock email validation
  - Comprehensive form validation for all inputs
  - Authentication is enforced to restrict Feed screen access to logged-in users
- **Feed Screen**:
  - View a list of posts with author name, content, likes, and comments
  - Create new posts
  - Like/unlike posts
  - Add comments to posts
- **Architecture**:
  - Clean architecture with domain, data, and presentation layers
  - State management using Flutter Bloc
  - Dependency injection with GetIt
- **Responsive Design**:
  - UI adapts to various screen sizes with a consistent layout
- **Mock Backend**:
  - Simulated API calls with in-memory data using mock repositories

## 📸 Screenshots

### 📝 Signup Page
![Signup Page](https://raw.githubusercontent.com/montashirFahim/flutter_app/main/assets/screens/signup.png)

### 🔐 Login Page
![Login Page](https://raw.githubusercontent.com/montashirFahim/flutter_app/main/assets/screens/login.png)

### 🔑 Forgot Password Page
![Forgot Password Page](https://raw.githubusercontent.com/montashirFahim/flutter_app/main/assets/screens/forgot_password.png)

### 📰 Feed Page
![Feed Page](https://raw.githubusercontent.com/montashirFahim/flutter_app/main/assets/screens/feed.png)

## Setup Instructions
1. **Prerequisites**:
   - Flutter SDK (version 3.8.1 or higher)
   - Dart SDK (included with Flutter)
   - A code editor (e.g., VS Code, Android Studio)

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/montashirFahim/flutter_app.git
   cd flutter_app
