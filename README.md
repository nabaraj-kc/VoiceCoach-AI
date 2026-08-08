# VoiceCoach AI

Flutter mobile and web application for speech tracking and vocal metrics analysis.

## Overview

VoiceCoach AI records speech audio, streams speech-to-text tokens, and analyzes speech patterns. It calculates filler word usage, words per minute (WPM), pause count, and an overall clarity score.

## Features

- Real-time speech-to-text: Uses on-device speech recognition or Web Speech API for live transcription.
- Filler word detection: Identifies filler words and phrases such as "um", "uh", "like", and "you know".
- Vocal metrics engine:
  - Words Per Minute (WPM): Compares speaking pace against target ranges (120 to 160 WPM).
  - Silence detection: Tracks pause frequency and duration.
  - Clarity score: Calculates a composite score based on filler rate and pace stability.
- Local storage: Saves session history and progress charts using Hive DB.

## Project Structure

```
lib/
├── core/               # Constants, utility functions, and theme definitions
├── features/           # Feature screens (home, recording, results, progress)
└── shared/             # Data models, services, and Riverpod providers
```

## Getting Started

### Prerequisites

- Flutter SDK 3.19 or higher

### Running the App

1. Clone the repository:
   ```bash
   git clone https://github.com/nabaraj-kc/VoiceCoach-AI.git
   cd VoiceCoach-AI
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Launch the app:
   ```bash
   flutter run -d chrome
   ```
