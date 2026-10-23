# Home to School

A modern Flutter application designed for school transit and transportation management, connecting parents, students, drivers, and schools.

## Features
- **Splash & Onboarding**: Seamless introduction and role selection.
- **Authentication**: Sign In, Sign Up with OTP verification, and Password recovery.
- **Home / Transit Dashboard**: Live transit status (Home to School / School to Home), bus tracking, and child info.
- **Messaging & Chat**: Direct communication between parents, drivers, and school coordinators.
- **Notifications**: Real-time push updates for bus arrival, delays, and announcements.
- **Profile & Settings**: Profile customization, language preferences, and safety terms.

## Architecture
- Clean modular structure with `features/`, `component/`, `config/`, `services/`, and `utils/`.
- State Management: GetX.
- Networking: Dio with interceptors and multipart support.
- Local Storage: SharedPreferences.
