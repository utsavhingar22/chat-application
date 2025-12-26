# Chat Application

A modern, beautiful Flutter chat application with a sleek UI design, featuring real-time messaging, contact management, and an intuitive user experience.

## 📱 Overview

This is a fully functional chat application built with Flutter that allows users to:
- Add and manage contacts
- Send and receive messages
- View chat history
- Explore offers and manage settings
- Experience smooth animations and modern UI design

## 🚀 Flutter Version

- **Flutter Version:** 3.3.10
- **Dart Version:** 2.18.6
- **Channel:** Stable

## ✨ Features

### Core Features
- **Contact Management**
  - Add new contacts with custom names
  - View all contacts in a beautiful list
  - See online/offline status for each contact
  - Avatar generation with color-coded initials

- **Messaging System**
  - Real-time message sending and receiving
  - Message history tracking
  - Timestamp display for each message
  - Auto-scroll to latest messages
  - Long-press on words to view dictionary definitions

- **Chat History**
  - View all previous conversations
  - Unread message count badges
  - Quick access to chat history
  - Time-based message grouping

- **User Interface**
  - Modern gradient-based design
  - Smooth animations and transitions
  - Responsive layout for all screen sizes
  - Custom tab switcher
  - Bottom navigation bar

### Additional Features
- **Explore/Offers Screen**
  - Featured offers display
  - Beautiful card-based layout
  - Gradient hero sections

- **Profile/Settings Screen**
  - User profile management
  - Notification settings
  - Dark mode toggle
  - Sound preferences
  - Privacy & security settings
  - Language selection

## 🎨 UI/UX Design

### Design System
- **Color Palette:**
  - Primary Gradient: `#667EEA` → `#764BA2` (Purple to Violet)
  - Background: `#F5F7FA` (Light Gray)
  - Text: `#1F2937` (Dark Gray)
  - Accent Colors: Various gradients for different sections

- **Typography:**
  - Font Family: Inter
  - Material Design 3 enabled
  - Responsive font sizing

- **Components:**
  - Custom avatar widgets with color-coded backgrounds
  - Gradient buttons and cards
  - Smooth animations and transitions
  - Custom tab switcher
  - Modern bottom navigation bar

### Screen Layouts
1. **Home Screen**
   - App bar with title
   - Tab switcher (Contacts/History)
   - Floating action button for adding contacts
   - Bottom navigation (Home, Explore, Profile)

2. **Contacts Tab**
   - List of all contacts
   - Online status indicators
   - Empty state with helpful instructions
   - Smooth scroll animations

3. **Chat Screen**
   - Message bubbles with gradient styling
   - User avatars
   - Input field with send button
   - Auto-scroll functionality
   - Dictionary integration for word meanings

4. **History Tab**
   - List of all conversations
   - Unread message badges
   - Last message preview
   - Time-based formatting

5. **Explore Screen**
   - Hero section with gradient
   - Featured offers cards
   - Information sections

6. **Settings Screen**
   - Profile header
   - Settings toggles
   - Account management
   - Support section

## 🏗️ Architecture

### Project Structure
```
lib/
├── controllers/
│   ├── message_controller.dart    # Manages messages and chat history
│   └── user_controller.dart        # Manages user/contact data
├── models/
│   ├── api_comment_model.dart     # API response models
│   ├── chat_history_model.dart    # Chat history data model
│   ├── message_model.dart         # Message data model
│   └── user_model.dart            # User/contact data model
├── services/
│   └── api_service.dart           # API integration for messages and dictionary
├── views/
│   ├── chat_history_tab.dart     # Chat history list view
│   ├── chat_screen.dart           # Individual chat interface
│   ├── home_screen.dart           # Main home screen
│   ├── offers_screen.dart         # Offers/Explore screen
│   ├── settings_screen.dart       # Settings/Profile screen
│   ├── users_list_tab.dart       # Contacts list view
│   └── widgets/
│       ├── avatar_widget.dart     # Custom avatar component
│       ├── custom_tab_switcher.dart # Custom tab component
│       └── word_meaning_bottom_sheet.dart # Dictionary bottom sheet
└── main.dart                      # App entry point
```

### Design Patterns
- **MVC (Model-View-Controller):** Separated concerns with controllers managing business logic
- **State Management:** Using StatefulWidget for local state management
- **Service Layer:** API calls abstracted in service classes

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  http: ^0.13.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

### Key Dependencies
- **http:** For API calls to fetch random messages and dictionary definitions
- **cupertino_icons:** iOS-style icons
- **flutter_lints:** Code quality and linting

## 🔄 Application Flow

1. **Launch App**
   - App initializes with global controllers
   - Home screen displays with Contacts tab active

2. **Adding Contacts**
   - Tap "Add Contact" floating button
   - Enter contact name in dialog
   - Contact appears in the list with random online status

3. **Starting a Chat**
   - Tap on any contact from the list
   - Chat screen opens with message history
   - Type message and send
   - Messages appear with timestamps

4. **Viewing History**
   - Switch to "History" tab
   - View all previous conversations
   - Tap any conversation to resume chat

5. **Additional Features**
   - Navigate to Explore for offers
   - Access Profile/Settings for app configuration
   - Long-press words in messages for dictionary definitions

## 🛠️ How to Run

### Prerequisites
- Flutter SDK 3.3.10 or compatible version
- Dart SDK 2.18.6
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd chat_application
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

   Or run on a specific device:
   ```bash
   flutter run -d <device-id>
   ```

4. **Build for production**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   ```

### Running on Different Platforms
- **Android:** `flutter run` (requires Android emulator or device)
- **iOS:** `flutter run` (requires iOS simulator or device, macOS only)
- **Web:** `flutter run -d chrome`
- **Desktop:** `flutter run -d windows/macos/linux`

## 🎯 Key Integrations

### API Integrations
- **DummyJSON API:** Fetches random comments/messages for chat simulation
  - Endpoint: `https://dummyjson.com/comments`
  
- **Dictionary API:** Provides word definitions on long-press
  - Endpoint: `https://api.dictionaryapi.dev/api/v2/entries/en/{word}`

### Features Implementation
- **Haptic Feedback:** Enhanced user experience with tactile feedback
- **Smooth Animations:** Page transitions and list animations
- **Auto-scroll:** Messages automatically scroll to bottom
- **Status Indicators:** Visual online/offline status
- **Unread Badges:** Message count indicators

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web (with limitations)
- ✅ Desktop (Windows, macOS, Linux)

## 🔧 Configuration

### Android Configuration
- Minimum SDK: 21
- Target SDK: 34
- Compile SDK: 34
- Kotlin Version: 1.7.10

### iOS Configuration
- Minimum iOS Version: 12.0
- Swift-based implementation

## 📝 Notes

- The application uses in-memory storage for contacts and messages (data resets on app restart)
- Online/offline status is randomly assigned for demonstration purposes
- API calls are made to external services for message content and dictionary definitions
- The app follows Material Design 3 guidelines with custom styling

## 👨‍💻 Development

### Code Quality
- Follows Flutter best practices
- Uses `flutter_lints` for code quality
- Proper separation of concerns
- Reusable widget components

### Future Enhancements
- Persistent storage (SQLite/Hive)
- Real-time messaging with WebSockets
- Push notifications
- Media sharing (images, files)
- Voice messages
- Group chats
- User authentication

## 📄 License

This project is created for educational/assignment purposes.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- DummyJSON API for test data
- Dictionary API for word definitions
- Material Design for UI guidelines

---

**Built with ❤️ using Flutter**
