# dvt_interview

A Flutter project for interviews.

## Conventions and Architecture

- **Project Description:** A new Flutter project.
- **Version:** 1.0.0+1
- **SDK Version:** >=3.3.0 <4.0.0

## Dependencies

- **flutter_bloc:** For implementing the BLoC architecture pattern.
- **mockito:** A testing utility for creating mock objects in tests.
- **location:** For handling device location services.
- **coverage:** A code coverage measurement tool.
- **bloc_test:** Provides utilities for testing BLoC components.
- **go_router:** A package for routing in Flutter applications.
- **firebase_core:** Core Firebase SDK dependencies for Flutter.
- **cloud_firestore:** Firestore SDK for Flutter, enabling interaction with Firestore database.
- **firebase_auth:** Firebase Authentication SDK for Flutter.
- **intl:** Internationalization and localization support for Flutter.

## Additional Notes

- **Uses BLoC Architecture:** Utilizes the BLoC architecture pattern along with `flutter_bloc` package, indicating a separation of concerns with business logic and UI components.
- **Firebase Integration:** Integration with Firebase services like Firestore and Authentication for backend functionalities.
- **Testing Support:** Includes packages like `mockito` and `bloc_test` for unit testing and mocking dependencies.
- **Routing:** Utilizes `go_router` for handling navigation within the application.
- **Asset Management:** Declares assets like icons and images for use within the application.

## How to Build the Project

To build the project, ensure you have Flutter installed, then run `flutter pub get` to fetch dependencies. After that, you can run `flutter build` or `flutter run` to build or run the project, respectively.
