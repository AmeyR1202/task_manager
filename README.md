<div align="center">

# Offline-First Task Manager

**A production-grade, offline-first Flutter application built with Clean Architecture.**  
A robust technical assessment submission focusing on architectural purity, maintainability, and clean code.

</div>

---

## Overview

Task Manager is a cross-platform Flutter application designed to allow users to create, manage, and track their daily tasks with full offline persistence. Rather than focusing on an extensive feature set, this project was intentionally engineered to demonstrate **senior-level software engineering practices**.

It is architected using **Feature-First Clean Architecture**, BLoC state management, and strict separation between the Domain, Data, and Presentation layers. This ensures that the core business logic remains completely agnostic of the UI and the underlying database implementation.

The codebase adheres strictly to rigorous linting rules, resulting in **zero analyzer warnings**.

---

## Features

### Task Management (Full CRUD)

- **Create & Edit:** Add new tasks or seamlessly edit existing ones with pre-filled form states and preserved UUIDs.
- **Delete & Undo:** Swipe-to-delete gestures integrated with SnackBar "UNDO" logic that gracefully handles complex component unmounting lifecycles.
- **Filtering:** Dynamic view filtering (All / Pending / Completed) seamlessly adapting empty-states.
- **Validation:** Strict form validation preventing empty task creation or null due dates.

### Offline Support

- 100% offline functionality — no network connection required.
- All tasks persist locally on the device across app launches.
- Type-safe SQL storage utilizing **Drift** (SQLite).

### Premium Modular UI / UX

- Custom Dark Mode with curated typography (Google Fonts - Outfit).
- Centralized semantic color tokens (`success`, `warning`, `error`) used for dynamic priority indicators.
- Highly modularized UI components (`DatePickerTileWidget`, `PrioritySelectorWidget`) completely avoiding "spaghetti" widget trees.
- Graceful dynamic empty states and error handling via BLoC emissions.

---

## Architecture

This project strictly adheres to **Clean Architecture** with a clear three-layer separation. The Domain layer is completely isolated from Flutter and external database packages.

```text
lib/
├── core/                   # Shared utilities, strict analysis options, routing, theming
│   ├── database/           # Drift database configuration
│   ├── router/             # GoRouter route definitions
│   └── theme/              # Centralized semantic dark theme
│
├── features/
│   └── tasks/
│       ├── data/           # Drift Local DataSource and RepositoryImpl
│       │   ├── datasource/ # SQLite queries and table interactions
│       │   └── repositories/# Maps Drift generated code -> Pure Entities
│       ├── domain/         # Entities, Repository Interfaces, UseCases
│       │   ├── entities/   # Pure Dart objects (TaskEntity)
│       │   ├── repositories/# Abstract interfaces
│       │   └── usecases/   # Business logic
│       └── presentation/   # BLoC, Pages, and highly modular custom Widgets
│           ├── bloc/       # TaskBloc, Events, States
│           ├── pages/      # TaskListPage, AddTaskPage
│           └── widgets/    # Reusable modular components
│
├── injection_container.dart# GetIt service locator registrations
└── main.dart
```

### Key Architectural Decisions

- **Manual Data Mapping:** The `TaskRepositoryImpl` manually maps Drift's auto-generated `TaskTableData` models into pure `TaskEntity` domain objects. This intentional "boilerplate" protects the Domain layer from being polluted by database logic.
- **BLoC State Management:** `flutter_bloc` ensures a strict separation of events and states, making the UI completely predictable and unit-testable.
- **UI Modularization:** Large pages like `AddTaskPage` were broken down into private helper widgets (`DatePickerTileWidget`, etc.) to maintain high readability in the `build` methods.
- **Dependency Injection:** `get_it` handles the injection of UseCases and Repositories, decoupling the architecture and enabling easy mocking for tests.
- **Equatability:** `equatable` is heavily used to prevent unnecessary UI rebuilds by enforcing value-based equality in BLoC states.

### Future Architectural Improvements
If I had more time or if this were an actively evolving production application, I would implement the following:

- **Functional Error Handling (`fpdart`):** I would update the `TaskRepository` interface to return `Future<Either<Failure, T>>` instead of relying on standard `try-catch` blocks. This strictly forces the BLoC layer to handle both success and failure states, completely eliminating unhandled runtime crashes.
- **Localization (`intl`):** Extracting all hardcoded strings (like 'Create Task', 'No pending tasks') into an `AppStrings` file or `.arb` localization files to support multiple languages and prevent typos.
- **Unit Testing:** Implementing comprehensive tests for the BLoC states and Domain UseCases utilizing `mocktail`.

---

## Tech Stack

| Layer                | Technology                               |
| -------------------- | ---------------------------------------- |
| SDK                  | Flutter ^3.12.0 / Dart ^3.12.0           |
| UI                   | Material 3 + Custom Styling              |
| State management     | flutter_bloc ^9.1.1 & equatable ^2.0.8   |
| Dependency injection | get_it ^9.2.1                            |
| Navigation           | go_router ^17.3.0                        |
| Database (ORM)       | drift ^2.33.0 & sqlite3_flutter_libs     |
| Code generation      | build_runner ^2.15.0 & drift_dev ^2.33.0 |
| Typography           | google_fonts ^8.1.0 (Outfit)             |

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.12.0`
- Dart SDK `^3.12.0`

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/AmeyR1202/task_manager.git
cd task_manager

# 2. Install dependencies
flutter pub get

# 3. Run code generation (Required for Drift Database)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

---

## Assumptions & Trade-offs

- **SQLite vs Hive:** `drift` was chosen over `hive` (NoSQL). While Hive is faster to set up, Drift provides type-safe SQL, normalized schema support, and robust relational querying capabilities that are essential for long-term scalability.
- **Dark Mode Only:** Light mode was intentionally excluded. A premium, centralized dark theme was implemented to focus heavily on a cohesive, polished UI aesthetic.
- **In-Memory Filtering:** For this assignment's scope, task filtering is handled functionally in the UI layer using the cached BLoC state, minimizing unnecessary database reads.
- **Single User Scope:** Built under the assumption of a local, single-user environment. However, the `TaskRepository` interface is designed so that syncing to a Remote API (like Firebase) could be added seamlessly without touching the Domain or Presentation layers.

---

<div align="center">
  <sub>Built with Flutter · Clean Architecture · BLoC · Drift</sub>
</div>
