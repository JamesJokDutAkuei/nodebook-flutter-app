# Nodebook - Flutter Notes App

A modern Flutter application for taking and managing notes with Firebase authentication and cloud storage.

## Features

- 🔐 **Secure Authentication** - Email/password signup and login
- 📝 **CRUD Operations** - Create, read, update, and delete notes
- ☁️ **Cloud Storage** - Notes synced across devices via Firestore
- 🎨 **Modern UI** - Clean, intuitive interface
- 🔄 **State Management** - BLoC pattern for reactive programming
- 🛡️ **Data Security** - User-specific data isolation

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                   │
├─────────────────────────────────────────────────────────────┤
│  AuthScreen          │  NotesScreen                         │
│  - Login/Signup UI   │  - Notes List UI                     │
│  - Input Validation  │  - Add/Edit/Delete UI                │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      STATE MANAGEMENT                       │
├─────────────────────────────────────────────────────────────┤
│                        NotesBloc                            │
│  Events: LoadNotes, AddNote, UpdateNote, DeleteNote        │
│  States: NotesInitial, NotesLoading, NotesLoaded, NotesError│
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                       SERVICE LAYER                         │
├─────────────────────────────────────────────────────────────┤
│                     FirebaseService                         │
│  - Authentication (signUp, signIn, signOut)                │
│  - Firestore CRUD (fetchNotes, addNote, updateNote, etc.)  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                        DATA LAYER                           │
├─────────────────────────────────────────────────────────────┤
│  Firebase Auth        │  Cloud Firestore                   │
│  - User Management    │  - Notes Storage                    │
│  - Session Handling   │  - Real-time Sync                  │
└─────────────────────────────────────────────────────────────┘
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── note.dart             # Note data model
├── services/
│   └── firebase_service.dart # Firebase operations
├── bloc/
│   └── notes_bloc.dart       # State management
└── screens/
    ├── auth_screen.dart      # Login/Signup UI
    └── notes_screen.dart     # Notes management UI
```

## Build Steps

### Prerequisites

1. **Flutter SDK** (3.7.2 or higher)
   ```bash
   flutter --version
   ```

2. **Firebase CLI**
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

3. **FlutterFire CLI**
   ```bash
   dart pub global activate flutterfire_cli
   ```

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd nodebook
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   ```bash
   flutterfire configure
   ```
   - Select your Firebase project
   - Choose platforms (Android, iOS)
   - This generates `lib/firebase_options.dart`

4. **Enable Firebase services**
   - Go to Firebase Console
   - Enable **Authentication** → Email/Password
   - Enable **Firestore Database** → Test mode
   - Set Firestore security rules:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId}/notes/{document=**} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
     }
   }
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS (requires macOS and Xcode):**
```bash
flutter build ios --release
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.6.0      # Firebase initialization
  firebase_auth: ^5.3.1      # Authentication
  cloud_firestore: ^5.4.3    # Database
  flutter_bloc: ^8.1.3       # State management
  cupertino_icons: ^1.0.8    # iOS icons
```

## Testing

**Run tests:**
```bash
flutter test
```

**Analyze code:**
```bash
flutter analyze
```

**Check formatting:**
```bash
flutter format --set-exit-if-changed .
```

## Usage

1. **Sign Up** - Create account with email and strong password
2. **Login** - Access your notes with credentials
3. **Add Notes** - Tap ➕ to create new notes
4. **Edit Notes** - Tap edit icon to modify existing notes
5. **Delete Notes** - Tap delete icon to remove notes
6. **Logout** - Use logout button to sign out securely

## Security Features

- **Password Validation** - Enforces strong passwords (8+ chars, uppercase, lowercase, numbers)
- **User Isolation** - Each user can only access their own notes
- **Secure Authentication** - Firebase handles password hashing and security
- **Data Encryption** - Firestore provides encryption at rest and in transit

## Code Quality

- ✅ **Zero Dart analyzer warnings**
- ✅ **Clean architecture** with separation of concerns
- ✅ **BLoC pattern** for predictable state management
- ✅ **Proper error handling** with user-friendly messages
- ✅ **Responsive UI** that works on different screen sizes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and analyzer
5. Submit a pull request

## Version History

- **v1.0.0** - Initial release with Firebase integration
- Complete CRUD operations for notes
- Modern UI with Material Design 3
- Strong password validation
- Zero Dart analyzer warnings

## License

This project is licensed under the MIT License.