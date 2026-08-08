# VoiceCoach AI 🎙️🧠

> **Real-Time Speech Coaching & Analytics App in Flutter**  
> *Engineered with live speech-to-text token processing, heuristic filler-word detection algorithms, local Hive persistence, and Riverpod state management.*

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 💡 Overview

**VoiceCoach AI** is a premium mobile and web speech analytics application built to help public speakers, interview candidates, and presenters refine their vocal clarity in real time. 

The application listens to live vocal input, streams real-time speech-to-text tokens, runs sliding-window filler word detection algorithms (`um`, `uh`, `like`, `you know`), tracks Words Per Minute (WPM), dynamically measures pauses, and calculates a overall speech clarity score.

---

## 🎨 UI Architecture (Stitch UI Dark System)

Designed with a high-contrast dark aesthetic for reduced eye strain during presentation recording:
- **Canvas Base**: `#0B0F1A`
- **Surface Cards**: `#121826`
- **Signal Blue Accents**: `#4DA3FF`
- **Vocal Purple Highlights**: `#6C5CE7`

---

## ⚡ Key Technical Features

- 🎙️ **Live Speech-to-Text Streaming**: Integrates on-device and browser Web Speech API for low-latency live transcription.
- ⏱️ **Real-Time Filler Word Detection**: Detects common filler phrases in real time with dynamic timestamp estimation.
- 📊 **Vocal Metrics Engine**:
  - **Words Per Minute (WPM)**: Tracks dynamic speaking pace against target ranges (120–160 WPM).
  - **Pause Frequency**: Measures silence durations to differentiate impactful pauses from hesitation.
  - **Clarity Score**: Algorithmically calculates a composite score based on filler rate and pace stability.
- 💾 **Offline-First Persistence**: Local session history and analytics charts powered by **Hive DB**.
- ☁️ **Cloud Function Integration**: Optional Firebase Cloud Functions integration for deep LLM feedback using Claude.

---

## 📦 Project Structure

```
lib/
├── core/
│   ├── constants/       # Speech targets & filler word lists
│   ├── theme/           # Stitch UI color palettes & text styles
│   └── utils/           # Transcript processing math
├── features/
│   ├── home/            # Dashboard & quick recording launch
│   ├── session/         # Recording studio & live wave visualizer
│   ├── results/         # Detailed session scorecards & filler breakdowns
│   └── progress/        # Dynamic performance trend charts
└── shared/
    ├── models/          # Session data models & metrics schemas
    └── services/        # Audio recorder & speech-to-text bindings
```

---

## 🚀 Getting Started

### 1. Prerequisites
- Flutter SDK 3.19 or higher
- Android Studio / Xcode

### 2. Run Locally
```bash
# Clone repository
git clone https://github.com/nabaraj-kc/VoiceCoach-AI.git
cd VoiceCoach-AI

# Install dependencies
flutter pub get

# Launch app (Chrome / Emulator / Device)
flutter run -d chrome
```

---

## 👨‍💻 Author

**Nabaraj KC**  
- GitHub: [@nabaraj-kc](https://github.com/nabaraj-kc)  
- Portfolio: [nabarajkc.com.np](https://nabarajkc.com.np)
