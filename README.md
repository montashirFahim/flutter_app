# Lii Lab Mobile Developer Assessment

This is a Flutter application developed for the Lii Lab Mobile Developer Assessment. The app implements an authentication flow (login, signup, forgot password) and a feed screen where users can view, create, like, and comment on posts. The backend is simulated using mock data and in-memory repositories.

## Features
- **Authentication**:
  - Login with email and password
  - Sign-up with name, username, email, password, date of birth, and gender
  - Forgot password functionality with mock email validation
  - Comprehensive form validation for all inputs
  - Authentication enforced to restrict Feed screen access to logged-in users
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
  - UI adapts to various screen sizes with consistent layout
- **Mock Backend**:
  - Simulated API calls with in-memory data using mock repositories

## Setup Instructions
1. **Prerequisites**:
   - Flutter SDK (version 3.8.1 or higher)
   - Dart SDK (included with Flutter)
   - A code editor (e.g., VS Code, Android Studio)

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/project_1.git
   cd project_1
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the Application**:
   ```bash
   flutter run
   ```

5. **Test Credentials**:
   - Use the following mock credentials to log in:
     - Email: `test@example.com`
     - Password: `password123`
   - Or create a new account using the sign-up form.

## Assumptions
- **Figma Design**: Since the Figma link was not provided, I designed a clean, modern UI based on standard authentication and social media feed patterns, ensuring responsiveness and usability.
- **Backend Absence**: All data operations (authentication, posts, likes, comments) are handled in-memory using mock repositories with simulated network delays to mimic API behavior.
- **Optional Features**: Implemented all optional features:
  - Liking posts
  - Creating new posts
  - Adding comments
  - State management with Bloc for real-time updates
  - Dependency injection with GetIt
  - Clean architecture for maintainability
- **Google/Apple Sign-In**: Excluded as they require backend services, which are not feasible with a mock setup.
- **Navigation**: Users are redirected to the Feed screen after successful login/signup and to the Login screen after logout or unauthenticated access attempts.

## Tools Used
- **Flutter**: For cross-platform UI development
- **Flutter Bloc**: For state management
- **GetIt**: For dependency injection
- **UUID**: For generating unique IDs
- **Dart**: For application logic

## Testing
- **Manual Testing**: Tested on Android and iOS emulators to ensure responsiveness and functionality.
- **Edge Cases**:
  - Invalid email/password during login
  - Duplicate email during signup
  - Empty form submissions
  - Logout and unauthenticated access attempts
- **Mock Data**: Predefined user (`test@example.com`) and sample posts are included for testing.

## Project Structure
- `lib/core/`: Dependency injection and utility files (mock data)
- `lib/features/auth/`: Authentication-related code (login, signup, forgot password)
- `lib/features/feed/`: Feed-related code (posts, likes, comments)
- `lib/main.dart`: Application entry point

## Submission
- Repository: [GitHub Repository Link]
- Deadline: 11:59 PM, June 25, 2025

## Contact
For any queries, please reach out to the Lii Lab team.

---
Developed by: A. S. M. Montashir Fahim
