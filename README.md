# CampusSync 🎓

A simple, offline-first school management application built with Flutter and SQLite. Manage users, schedules, events (with auto-sync to schedule on join), and get AI-powered feedback on coursework via an external API (e.g., OpenAI or Perplexity).

## 🚀 Features

- **User Management**: Email-based login/register with local SQLite storage
- **Schedule Management**: CRUD for personal schedules (view, add, edit, delete)
- **Event Management**: Browse/join events; joined events auto-add to your schedule
- **AI Feedback**: Submit coursework text for instant review and suggestions (uses Perplexity/OpenAI API)
- **Responsive UI**: Designed from Figma prototypes, with clean Material Design
- **Offline Support**: All data stored locally; AI requires internet

## 📋 Prerequisites

- Flutter SDK (v3.0+ recommended)
- Dart SDK (included with Flutter)
- Android Studio or Xcode (for emulator/device testing)
- An API key for AI feedback (e.g., from OpenAI or Perplexity). Free tiers work for MVP

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd campussync
```

### 2. Install Dependencies

Run this to fetch all packages (sqflite, provider, http, dotenv, etc.):

```bash
flutter pub get
```

### 3. Configure Environment (for AI API)

Create a `.env` file in the project root (add to `.gitignore` for security):

```text
PERPLEXITY_API_KEY=your_perplexity_key_here
# Or for OpenAI: OPENAI_API_KEY=your_openai_key_here
```

Ensure `.env` is listed in `pubspec.yaml` under assets:

```yaml
flutter:
  assets:
    - .env
```

### 4. Generate/Setup Database

No extra steps needed—SQLite DB (`school.db`) auto-creates on first run via `DatabaseService`.

### 5. Optional: Seed Sample Data

For testing, add sample users/events in `DatabaseService._onCreate()` (e.g., insert dummy records).

## ▶️ Running the App

### Connect Device/Emulator

- **Android**: `flutter devices` to list; use emulator or USB device
- **iOS**: Requires macOS/Xcode; `flutter devices`

### Run in Debug Mode

```bash
flutter run
```

App starts at login screen. Test flow: Register/Login > Home > Schedule/Events > AI Feedback.

### Build for Release

**Android APK:**

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

**iOS (macOS only):**

```bash
flutter build ios --release
```

Archive in Xcode for App Store/TestFlight.

### Hot Reload/Test

- **During dev**: Save file → Auto-reloads
- **Unit Tests**: `flutter test` (add tests in `test/` folder)
- **Widget Tests**: Focus on screens like `login_screen_test.dart`

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry, providers, routing
├── models/                    # Data models (User, Schedule, Event)
├── services/                  # DB (SQLite) & AI API logic
│   ├── database_service.dart
│   └── ai_service.dart
├── providers/                 # State management (Provider)
│   ├── user_provider.dart
│   ├── schedule_provider.dart
│   ├── event_provider.dart
│   └── chat_provider.dart     # For AI interactions
├── screens/                   # UI pages
│   ├── auth/                  # Login/Register
│   ├── home/                  # Dashboard with sections
│   ├── schedule/              # Schedule CRUD
│   ├── event/                 # Events list/join
│   └── aiAgent/               # Feedback screen
├── utils/                     # Helpers
│   ├── routes.dart
│   └── constants.dart
└── widgets/                   # Reusable components (e.g., cards, buttons)
```

## 🔑 API Integration Notes

- **AI Feedback**: Configured for Perplexity (via dotenv). Swap to OpenAI in `ai_service.dart` if needed
- **Error Handling**: API calls wrapped in try-catch; shows Snackbars on failure
- **Rate Limits**: Free tiers have quotas—handle with `flutter_secure_storage` for retries if expanded

## 🐛 Troubleshooting

- **Pub Get Fails**: Run `flutter clean` then `flutter pub get`
- **DB Errors**: Delete app data/emulator → Reinstall to reset SQLite
- **AI 401/403**: Check `.env` key; ensure no trailing spaces
- **Routing Issues**: Verify `Routes.generateRoute` in `routes.dart`
- **Logs**: Use `flutter run -v` for verbose output

## 🤝 Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add some amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

MIT License - Feel free to use/modify!

## 📞 Support

Built in a 24-hour hackathon sprint. Questions? Open an issue or ping the dev.

---

**Happy Coding! 🎓✨**

*Last Updated: October 24, 2025*