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
 ````

3. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

4. **Run the Application**:

   ```bash
   flutter run
   ```

5. **Test Credentials**:

   * Use the following mock credentials to log in:

     * Email: `test@example.com`
     * Password: `password123`
   * Or create a new account using the sign-up form.

## Assumptions

* **Backend Absence**: All data operations (authentication, posts, likes, comments) are handled in-memory using mock repositories with simulated network delays to mimic API behavior.
* **Optional Features**: Implemented all optional features:

  * Liking posts
  * Creating new posts
  * Adding comments
  * State management with Bloc for real-time updates
  * Dependency injection with GetIt
  * Clean architecture for maintainability
* **Google/Apple Sign-In**: Excluded as they require backend services, which are not feasible with a mock setup.
* **Navigation**: Users are redirected to the Feed screen after successful login/signup and to the Login screen after logout or unauthenticated access attempts.

## Tools Used

* **Flutter**: For cross-platform UI development
* **Flutter Bloc**: For state management
* **GetIt**: For dependency injection
* **UUID**: For generating unique IDs
* **Dart**: For application logic

## Testing

* **Manual Testing**: Tested on Chrome to ensure responsiveness and functionality.
* **Edge Cases**:

  * Invalid email/password during login
  * Duplicate email during signup
  * Empty form submissions
  * Logout and unauthenticated access attempts
* **Mock Data**: Predefined user (`test@example.com`) and sample posts are included for testing.

## Project Structure

* `lib/core/`: Dependency injection and utility files (mock data)
* `lib/features/auth/`: Authentication-related code (login, signup, forgot password)
* `lib/features/feed/`: Feed-related code (posts, likes, comments)
* `lib/main.dart`: Application entry point

## Submission

* Repository: \[[https://github.com/montashirFahim/flutter\_app](https://github.com/montashirFahim/flutter_app)]
* Deadline: 11:59 PM, June 25, 2025

## Contact

For any queries, please reach out to **[montashirfahim25@gmail.com](mailto:montashirfahim25@gmail.com)**

---

Developed by: **A. S. M. Montashir Fahim**
