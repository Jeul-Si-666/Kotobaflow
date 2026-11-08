# KotobaFlow

<p align="center">
  <strong>言葉を、自然に。</strong><br/>
  Learn Japanese vocabulary naturally.
</p>

<p align="center">
  An offline-first Japanese vocabulary learning application built with Flutter.
</p>

---

## About

**KotobaFlow** is a Japanese vocabulary learning application designed to help learners study and remember Japanese words through a simple, structured, and focused learning experience.

The initial development focuses on **JLPT N5 vocabulary**, with an emphasis on accessibility, simplicity, and offline usability.

The application follows a Japanese Editorial Minimalism design direction, combining warm ivory backgrounds, vermilion accents, and clean typography.

## Project Goals

- Provide a structured Japanese vocabulary learning experience.
- Support offline learning without requiring a permanent internet connection.
- Help users build consistent vocabulary-learning habits.
- Provide a foundation for future adaptive learning and spaced repetition features.

## MVP Scope

The initial MVP focuses on:

- JLPT N5 vocabulary.
- Japanese vocabulary with hiragana readings.
- Indonesian vocabulary meanings.
- Local data storage.
- Android application support.

> Note: Features are subject to the current implementation status.

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI framework |
| Dart | Primary programming language |
| SQLite | Local database |
| Drift | Type-safe database integration |
| Riverpod | State management |
| GoRouter | Application navigation |

## Design System

KotobaFlow uses a Japanese Editorial Minimalism visual identity.

| Color | Hex | Usage |
|---|---|---|
| Warm Ivory | `#F7F4ED` | Primary background |
| Vermilion | `#D94A38` | Primary accent |
| Charcoal | `#292824` | Main text |
| Soft Beige | `#E8E1D5` | Supporting surfaces |

The design prioritizes readability, whitespace, clear visual hierarchy, and a calm learning environment.

## Getting Started

### Prerequisites

Install the following tools:

- Flutter SDK
- Dart SDK
- Android SDK (for Android builds)
- Visual Studio (for Windows desktop builds)

Verify your Flutter installation:

```bash
flutter doctor
```

### Installation

Clone the repository:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Navigate to the project directory:

```bash
cd kotobaflow
```

Install dependencies:

```bash
flutter pub get
```

### Run the Application

Run on the default available device:

```bash
flutter run
```

Run on Windows:

```bash
flutter run -d windows
```

List available devices:

```bash
flutter devices
```

## Build

### Android APK

Build a release APK:

```bash
flutter build apk --release
```

The generated APK can be found at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

### Windows

Build the Windows release application:

```bash
flutter build windows --release
```

## Project Structure

The project follows a feature-oriented structure.

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme/
├── core/
│   ├── database/
│   ├── constants/
│   └── utils/
├── features/
│   ├── home/
│   ├── vocabulary/
│   ├── flashcard/
│   ├── quiz/
│   ├── review/
│   └── statistics/
└── shared/
    └── widgets/
```

The structure may evolve as development progresses.

## Data & Storage

KotobaFlow is designed with an offline-first approach.

The local database uses SQLite with Drift integration.

The planned vocabulary data source includes the OpenJLPT dataset, initially targeting JLPT N5.

Data integration must preserve stable vocabulary identifiers and existing learning progress.

## Roadmap

- [x] Initial Flutter project setup
- [x] Windows development environment setup
- [x] Android build environment setup
- [ ] Finalize vocabulary database integration
- [ ] Integrate OpenJLPT N5 vocabulary
- [ ] Prepare Indonesian vocabulary meanings
- [ ] Complete vocabulary learning workflow
- [ ] Implement flashcards and quizzes
- [ ] Implement spaced repetition
- [ ] Add learning statistics
- [ ] Improve Android user experience
- [ ] Cloud synchronization (future consideration)

## Dataset Attribution

KotobaFlow plans to use vocabulary data from:

**OpenJLPT**  
https://github.com/evanclan/OpenJLPT

OpenJLPT is a community-maintained Japanese language learning dataset.

The dataset is distributed under the Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license. Please refer to the original repository and its `NOTICE.md` for attribution and license requirements.

## License

The licensing of KotobaFlow's own source code and the licensing of third-party datasets should be documented separately.

## Author

Developed as an independent learning project focused on Japanese language learning and software engineering.

---

<p align="center">
  <strong>KotobaFlow</strong><br/>
  言葉を、自然に。
</p>