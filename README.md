
# 📱 Flutter-Firebase App

This is a **Flutter-based app** demonstrating:

- 📋 Firebase Authentication (Email / Phone with OTP)
- 📚 Course Listing & Detail Screens (Video & PDF Placeholder)
- 📞 Simulated Audio Call Screen using ZegoCloud
- 🧭 `go_router` based navigation
- 🧠 `flutter_bloc` state management
- ☁️ Firestore integration
- 💡 Clean, modern UI and working APK-ready MVP

---

## 🚀 Features

| Feature               | Description                                                             |
|-----------------------|-------------------------------------------------------------------------|
| 🔐 **Login/Signup**   | Firebase Auth using email or phone with OTP                             |
| 🏠 **Home**           | Shows Firestore user data on login                                      |
| 📘 **Courses**        | List of courses from Firestore                                          |
| 🎥 **Course Detail**  | UI-only screen with video/PDF placeholders                              |
| 📞 **Audio Call**     | Simulated screen with ZegoCloud (dummy token from Firestore)            |
| 🗂 **Bottom NavBar**  | Navigate between Home and Courses screens                                |

---

## 🧰 Project Structure

```
lib/
├── blocs/             # BLoC files (AuthBloc, UserBloc, etc.)
├── constants/         # App-wide constants
├── screens/           # UI Screens (Login, Home, CourseList, etc.)
├── routes/            # go_router setup
├── services/          # Firebase and API services
├── widgets/           # Reusable widgets
└── main.dart          # Entry point
```

---

## 🛠️ Getting Started

### 1. 📦 Install Dependencies

```bash
flutter pub get
```

### 2. 🔥 Firebase Setup

- Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com).
- Add an Android app to your Firebase project.
- Download the `google-services.json` and place it inside:

```
android/app/google-services.json
```

- Enable **Authentication** methods (Email/Password and Phone).
- Enable **Cloud Firestore** and create necessary collections:
  - `DummyData` (for audio call token)
  - `User` → `uid` → `{ name, email, phoneNumber }`
  - `Courses` (for listing)

### 3. 🧪 ZegoCloud Setup

- Register at [ZegoCloud](https://console.zegocloud.com).
- Use `zego_uikit_prebuilt_call: ^4.17.5`
- Add your App ID and App Sign in the Zego call screen (or fetch dummy token from Firestore).

---

## ▶️ Run the App

### 🐣 Debug

```bash
flutter run
```

### 📦 Build APK

```bash
flutter build apk --release
```

---

## 📱 Android Permissions

Ensure the following permissions are added in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

---

## 🧪 Testing

- Authentication flows (Login / OTP)
- Course list loads from Firestore
- Zego Call screen displays dummy token correctly
- Bottom navigation transitions correctly between screens

---

## 📌 Dependencies

```yaml
firebase_core: ^2.30.0
firebase_auth: ^4.17.8
cloud_firestore: ^4.17.4
flutter_bloc: ^8.1.5
go_router: ^14.1.3
zego_uikit_prebuilt_call: ^4.17.5
```

---
