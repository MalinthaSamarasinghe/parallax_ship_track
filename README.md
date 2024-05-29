# Overview of Assignment - Mobile App Developer

## Objective
Develop a mobile app that provides insights about the shipping progress of customer orders using the Flutter framework. The app should include both UI and functionalities as outlined in the requirement document. Refer to the Figma design file for UI/UX guidance.

## Time Frame
3 days

## Requirements
### Login Screen
- Loading Page: Implement a loading page with the merchant logo.
- Login Functionality: Allow users to log in using their merchant account details, with fields for email and password.

### Dashboard View
- Widgets: Design and implement widgets for:
    - Orders statistics
    - Finance statistics
    - Status statistics

### Orders Section
- View Orders by Status: Display orders separately based on their status.
- Download Orders: Implement functionality to download orders as Excel files.
- View & Add Remarks: Enable viewing of remarks added to orders and the ability to add new ones.

### Order Location Tracking
- Implement a location API service like Google Maps API to illustrate the order's transportation.
- Adhere to standards provided in the Figma design.

### Push Notifications
- Implement a push notification service using Firebase Services when an order status is updated.
- You might need a specific API to update order status using Postman or a similar service.

## General Instructions
- Development Framework: Use Flutter for app development.
- Backend: Utilize Postman Mock Server or a similar tool for simulating backend services.
- Design Reference: Use the provided Figma design file to guide development.
- Documentation: Provide clear documentation for app setup, including instructions for configuring the mock server.
- Submission: Submit the source code via a publicly accessible GitHub repository along with setup instructions and a brief implementation report.

## Suggestions to Improve Code Quality
- Design Pattern
    - Structure the Flutter project with a proper design pattern such as BLoC, MVC, or MVVM.
    - Separate business logic from UI components to ensure a clear separation of concerns.

- State Management
    - Use state management solutions like Bloc to manage application state efficiently and maintain a responsive user interface.

- Error Handling
    - Implement robust error handling to provide user-friendly error messages and ensure smooth app functionality in various scenarios.

- Code Maintainability
    - Comment on your code to enhance readability and maintainability.
    - Write unit tests for critical parts of the codebase to ensure functionality and reliability.

# Implementation Details

## Covered Aspects
- Changed App Name & Icon.
- Implemented splash screen with merchant logo.
- Integrated Firebase functionalities.
- User login / signup / forgot password functionality with email and password.
- Dashboard view with widgets for orders, finance, and status statistics.
- Orders section with status-based viewing.

## Uncovered Aspects
- Orders section downloading as Excel files, and remark functionality.
- Order location tracking using Google Maps API.
- Push notifications for order status updates using Firebase Services.
- Utilize Postman Mock Server or a similar tool for simulating backend services.
- Write unit tests for critical parts of the codebase to ensure functionality and reliability.

# Developer's Guide

## Prerequisites
- Flutter SDK ✅ Working Flutter SDK `3.19.0` 👉 [Download Flutter SDKs](https://docs.flutter.dev/release/archive?tab=windows)
- Dart
- Firebase account
- Google Maps API key

## Installation
- Clone the project from here, 👉 [Clone the Repository](https://github.com/MalinthaSamarasinghe/parallax_ship_track.git)

## Install dependencies
```dart
flutter pub get
```

## Set up the Postman Mock Server
- Create a mock server in Postman.
- Import the provided collection (if any) to Postman.
- Set the mock server URL in your Flutter app’s API configuration.

# Project Guidelines

## State Management
- This project uses <a href="https://bloclibrary.dev/#/"><img src="https://tinyurl.com/bloc-library" alt="Bloc Library"></a> as a state management package.

## Localization
- This app supports multiple languages. Currently supporting the following languages,
    - English

- [Easy localization](https://pub.dev/packages/easy_localization) extension to handle app language.

- Translation files are located in the following directory,
```
assets
└── translations
    └── en-US.json
```

- Codegen Loader & Locale Keys files are located in the following directory,
```
lib
└── core
    └── locales
        ├── codegen_loader.g.dart
        └── locale_keys.g.dart
```

- Run the following commands in the terminal to auto-generate local keys,

- Generate codegen loader\
`
flutter pub run easy_localization:generate -S "assets/translations" -O "lib/core/locales"
`

- Generate keys\
`
flutter pub run easy_localization:generate -S "assets/translations" -O "lib/core/locales" -o "locale_keys.g.dart" -f keys
`

- 🔥 Tip - Use [i18n manager](https://pub.dev/packages/easy_localization)  translation management app to handle thing easier

## Best Coding Practices
- Directories and files should be named in `snake_case`.
```
dir_one
└── my_folder
    ├── example.dart
    └── custom_class.dart
```

- All private variables and private methods should start with underscores
```dart
// Do
bool _isLoading = true;
void _myFunction() {}

// Do not
bool isLoading = true;
void myFunction() {}
```

- Constants, variables, parameters, and named parameters should be named in `lowerCamelCase` 
- Classes, types, extension names, and enums should be typed in `UpperCamelCase`
- Proper and **meaningful** naming practices should be followed

👉 Please read [best_coding_practices.md](https://github.com/wad-coding/smaboo_business/blob/main/best_coding_practices.md) file for more information

# Implementation Report

## Approach
- Followed a modular design pattern to separate business logic from UI components.
- Utilized the Bloc pattern for efficient state management.
- Utilized Firebase for the backend.
- Ensured robust error handling and user-friendly messages.
- Focused on code maintainability with thorough comments and a clear structure.

## Challenges
- This project involved only 2 days of work, so the uncovered aspects will be implemented soon. The developer has previous experience and knowledge of the uncovered aspects of this project.

## Future Improvements
- Add more comprehensive unit and integration tests.
- Enhance UI/UX based on user feedback.
- Implement additional features as needed.

## Test Account
You can use the following details to log in to the app or create a new account. Using the test account is recommended:
- Email: malintha.wad@gmail.com
- Password: 123456
