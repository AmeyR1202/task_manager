<div align="center">

# Offline-First Task Manager

**A production-grade, offline-first Flutter application built with Clean Architecture.**  
A robust technical assessment submission focusing on architectural purity, maintainability, and clean code.

</div>

---

## Overview

Task Manager is a cross-platform Flutter application designed to allow users to create, manage, and track their daily tasks with full offline persistence. Rather than focusing on an extensive feature set, this project was intentionally engineered to demonstrate **senior-level software engineering practices**.

It is architected using **Feature-First Clean Architecture**, BLoC state management, and strict separation between the Domain, Data, and Presentation layers. This ensures that the core business logic remains completely agnostic of the UI and the underlying database implementation.

---

## Features

### Available now

#### Task Management (CRUD)

- Create new tasks with title, description, priority, and due dates
- Delete existing tasks via swipe-to-delete gesture
- Toggle task completion status instantly
- Prevent empty task creation via strict form validation

#### Offline Support

- 100% offline functionality — no network connection required
- All tasks persist locally on the device across app launches
- Type-safe SQL storage utilizing Drift (SQLite)

#### Premium UI / UX

- Custom Dark Mode with curated typography (Google Fonts - Outfit)
- Visual color indicators for task priorities (High, Medium, Low)
- Graceful empty states and error handling via BLoC state emissions
- SnackBar integration with "UNDO" functionality for accidental deletions

### Roadmap (Pending Implementation)

| Feature                        | Status  | Branch              |
| ------------------------------ | ------- | ------------------- |
| Task Filtering (All/Completed) | Planned | `feature/filtering` |
| Edit Existing Tasks            | Planned | `feature/edit-task` |

---

## Architecture

This project strictly adheres to **Clean Architecture** with a clear three-layer separation. The Domain layer is completely isolated from Flutter and external database packages.

```
lib/
├── core/                   # Shared utilities, routing, theming
│   ├── database/           # Drift database configuration
│   ├── router/             # GoRouter route definitions
│   └── theme/              # Centralized dark theme and Google Fonts
│
├── features/
│   └── tasks/
│       ├── data/           # Drift Local DataSource and RepositoryImpl
│       │   ├── datasource/ # SQLite queries and table interactions
│       │   └── repositories/# Maps Drift generated code -> Pure Entities
│       ├── domain/         # Entities, Repository Interfaces, UseCases
│       │   ├── entities/   # Pure Dart objects (TaskEntity)
│       │   ├── repositories/# Abstract interfaces
│       │   └── usecases/   # Business logic (e.g., GetTaskUseCase)
│       └── presentation/   # BLoC, Pages, and custom Widgets
│           ├── bloc/       # TaskBloc, Events, States
│           ├── pages/      # TaskListPage, AddTaskPage
│           └── widgets/    # Reusable components (TaskItemWidget)
│
├── injection_container.dart# GetIt service locator registrations
└── main.dart
```

### Key Architectural Decisions

- **Manual Data Mapping:** The `TaskRepositoryImpl` manually maps Drift's auto-generated `TaskTableData` models into pure `TaskEntity` domain objects. This intentional "boilerplate" protects the Domain layer from being polluted by database logic.
- **BLoC State Management:** `flutter_bloc` ensures a strict separation of events and states, making the UI completely predictable and unit-testable.
- **Dependency Injection:** `get_it` handles the injection of UseCases and Repositories, decoupling the architecture and enabling easy mocking for tests.
- **Equatability:** `equatable` is heavily used to prevent unnecessary UI rebuilds by enforcing value-based equality in BLoC states.

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

## Branching Strategy

This project simulates a production environment utilizing a **feature branch → dev → main** workflow.

```
main          ← production-ready, clean history
  └── feat/   ← individual feature branches merged into main
        ├── feat/task-crud
        ├── feat/filtering
        └── feat/edit-task
```

### Rules

- `main` is protected — all code enters via well-defined feature branches.
- Feature branches are named using conventional prefixes (e.g. `feat/task-crud`).
- **Conventional Commits:** All commit messages follow industry standards to maintain a readable Git history (e.g., `feat(ui): added task item widget`, `fix(bloc): resolved unmounted context exception`).

---

## Assumptions & Trade-offs

- **SQLite vs Hive:** `drift` was chosen over `hive` (NoSQL). While Hive is faster to set up, Drift provides type-safe SQL, normalized schema support, and robust relational querying capabilities that are essential for long-term scalability.
- **Dark Mode Only:** Light mode was intentionally excluded. A premium, centralized dark theme was implemented to focus heavily on a cohesive, polished UI aesthetic.
- **Single User Scope:** Built under the assumption of a local, single-user environment. However, the `TaskRepository` interface is designed so that syncing to a Remote API (like Firebase) could be added seamlessly without touching the Domain or Presentation layers.

---

<div align="center">
  <sub>Built with Flutter · Clean Architecture · BLoC · Drift</sub>
</div>
