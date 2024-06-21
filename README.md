# Flutter Clean Architecture Bloc App

This Flutter application follows the Clean Architecture principles and utilizes the Bloc pattern for state management. The app fetches daily news from the News API, displays them, and provides the option to save news articles to a local SQLite database.

## Architecture Overview

The project follows the Clean Architecture principles, separating the app into different layers:

- **Presentation Layer**: Contains the Flutter widgets, Blocs, and UI-related logic.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources such as APIs and Authentication.

## State Management

The app uses the Bloc pattern for state management. Blocs are responsible for managing the application's state and business logic.

## Service Locator

The `get_it` package is used as a service locator for dependency injection. It helps manage the app's dependencies in a clean and organized way.

## API Requests

Retrofit is used for making API requests to the News API. It provides a type-safe way to interact with RESTful APIs.

## Dart Object Comparison

The `equatable` package is employed for efficient comparison of Dart objects. This is particularly useful when working with Blocs and state changes.

## .ENV File
The .env file contains secret API key from free news api website.

## Firebase Integration

Firebase Crashlytics: Real-time crash reporting for monitoring app stability.
Firebase Analytics: Tracks user engagement and app performance metrics for data-driven decisions.
Firebase Authentication: Provides secure authentication methods, including email and password authentication.

## Navigation
Navigation within the app is managed using Flutter's built-in system, providing seamless transitions between screens for a smooth user experience.

## Pages
## News List Page
Displays a list of daily news articles fetched from the News API. Users can scroll through headlines and view summaries.

## News Details Page
Shows detailed information about a selected news article, including the full content and publication details.

## User Management

- Logging Out: Users can securely log out of their accounts using Firebase Authentication.
- Analytics and User Engagement
- Firebase Analytics tracks user interactions and app usage patterns to optimize user engagement strategies and enhance the app's performance.

## Error Handling
The app includes robust error handling mechanisms using Dart's try-catch blocks and Firebase Crashlytics, ensuring proactive issue resolution and improved reliability.

## Unit Testing
Comprehensive unit tests validate business logic, including use cases, Blocs, and data repositories, ensuring code reliability and stability.

## Assumptions and Design Decisions
- Clean Architecture: Adopted to ensure separation of concerns and maintainability.
- Bloc Pattern: Chosen for robust state management and scalability.
- Firebase Services: Integrated for backend functionality and analytics, leveraging Firebase's real-time features.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/yunus6116/Flutter-Bloc-Clean-Architecture.git

2. Navigate to the project directory:
    ```bash
    cd your-repo
3. Add your News API key:
   <br>
   Open the .env file from root folder and locate the API_KEY variable. Replace 'your_api_key_here' with your actual News API key. If you don't have an API key, you can obtain one by signing up on the News API website.
   Note: Keep your API key secure and do not share it publicly. Consider using environment variables or other secure methods to manage sensitive information in a production environment.

5. Install dependencies:

   ```bash
   flutter pub get

6. Run the app:

   ```bash
   flutter run
   


### TEST CREDENTIALS
- Email - test1@gmail.com
- Password - 12345678

- Email - test2@gmail.com
- Password - 87654321
