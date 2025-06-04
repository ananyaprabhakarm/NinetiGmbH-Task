# Flutter User Management App

A Flutter application that demonstrates user management functionality using the [DummyJSON API](https://dummyjson.com), integrated with the BLoC state management pattern and clean code architecture.

## 🚀 Features

- 🔁 Infinite scrolling user list with pagination (`limit` / `skip`)
- 🔍 Real-time search by user name
- 📦 Clean folder structure and scalable architecture
- 🔄 API integration using `http` package
- ⚙️ BLoC pattern with flutter_bloc

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (3.x preferred)
- Dart SDK
- Git

### Installation
```
git clone https://github.com/your-username/flutter-user-management-bloc.git
cd flutter-user-management-bloc
flutter pub get
flutter run
```

### 📂 Folder Structure

lib/
├── core/                  # Shared constants, network config
├── data/                 
│   ├── models/            # User, Post, Todo models
│   └── services/          # API services
├── logic/                
│   └── bloc/              # User BLoC (event, state, bloc)
├── presentation/         
│   ├── screens/           # UI screens
│   └── widgets/           # Reusable UI components
├── main.dart              # App entry point

### 🌐 API Endpoints Used

Users: https://dummyjson.com/users?limit=20&skip=0
Search Users: https://dummyjson.com/users/search?q=query
User Posts: https://dummyjson.com/posts/user/{userId}
User Todos: https://dummyjson.com/todos/user/{userId}

### 🧠 Architecture Overview

This app follows a feature-first clean architecture using BLoC:

    UserEvent → represents user actions (e.g. FetchUsers, SearchUsers)
    UserBloc → handles business logic and API calls
    UserState → emits results (UserLoading, UserLoaded, UserError)
    UI uses BlocBuilder to rebuild based on the state

### 🙌 Acknowledgements

DummyJSON for providing the mock API
The Flutter and Dart teams
BLoC library maintainers
