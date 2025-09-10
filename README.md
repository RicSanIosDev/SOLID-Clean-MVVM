//
//  README.md
//  SOLID + Clean Arq + MVVM
//
//  Created by ricardo sanchez on 10/9/25.
//

# iOS Clean Architecture + SOLID + MVVM

This project serves as a boilerplate and a practical example for building scalable, testable, and maintainable iOS applications using UIKit. Its primary purpose is to demonstrate the implementation of the following design principles and patterns:

-   **Clean Architecture**
-   **SOLID Principles**
-   **MVVM-C** (Model-View-ViewModel-Coordinator)
-   **Dependency Injection (DI)**

The sample feature is a simple application that fetches and displays a list of users from a public API, allowing navigation to a user detail screen.

## Architectural Overview

The architecture is designed to enforce a clear separation of concerns, reduce coupling, and maximize testability.

### 1. Clean Architecture

The project is divided into three main layers, following the Dependency Rule (dependencies always point inwards, towards the `Domain`).

-   **`Domain` Layer:** The core of the application. It contains pure business logic with no dependencies on external frameworks like UIKit or data sources.
    -   **Entities:** Pure data models (`User`).
    -   **Use Cases:** Represent specific application actions (`GetUsersUseCase`).
    -   **Repository Protocols:** Define the contracts that the `Data` layer must implement (`UserRepository`).

-   **`Data` Layer:** Responsible for implementing the data retrieval logic. It conforms to the protocols defined in the `Domain` layer.
    -   **Repositories:** Concrete implementations of the repository protocols (`APIUserRepository`).
    -   **Network:** API clients, data mappers, and other logic related to external data sources.

-   **`Presentation` Layer:** Responsible for the UI. This project uses the MVVM-C pattern.
    -   **View:** "Dumb" `UIViewController`s that are only responsible for displaying data.
    -   **ViewModel:** Contains the presentation logic and UI state. It communicates with the `Use Cases`.
    -   **Coordinator:** Manages the navigation flow, creating and presenting ViewControllers and ViewModels.

### 2. SOLID Principles

These five principles guide the design of every class and struct to ensure the code is flexible and maintainable:
-   **S**ingle Responsibility: Each component has only one reason to change.
-   **O**pen/Closed: Open for extension, but closed for modification.
-   **L**iskov Substitution: Subtypes must be substitutable for their base types.
-   **I**nterface Segregation: Many client-specific interfaces are better than one general-purpose interface.
-   **D**ependency Inversion: Depend upon abstractions (protocols), not concretions.

### 3. Dependency Injection (DI)

Instead of objects creating their own dependencies, they are "injected" from an external source (usually via the initializer). This is crucial for decoupling and allows for easily swapping dependencies with Mocks or Fakes during testing.

The **`DIContainer`** acts as the **Composition Root**, a centralized place where the application's dependency graph is constructed.

## Project Structure

├── Application/ // App entry point and global configuration
├── Domain/ // Business logic and models
├── Data/ // Data source implementation
└── Presentation/ // UI Layer (Coordinators, Views, ViewModels)
└── Core/ // Base protocols and classes for the UI

## Getting Started

### Prerequisites

-   Xcode 16 or later
-   Swift 5.10 or later

### Installation

1.  Clone the repository:
    ```sh
    git clone https://YOUR-REPOSITORY-URL.git
    ```
2.  Open the `.xcodeproj` file in Xcode.
3.  Build and run the project (`Cmd + R`).

## Contact

Ricardo Sanchez - ricsaniosdev@egmail.com

Project Link: [https://github.com/your-username/SOLID-Clean-Arq + MVVM](https://github.com/RicSanIosDev/SOLID-Clean-MVVM)
