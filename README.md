# **Solar Generation Tracker**

A Flutter-based mobile application that visualizes solar energy generation data, allowing users to monitor and analyze energy trends over time. Built with clean architecture principles, it uses Flutter, Bloc for state management, Hive for local caching, and integrates charting libraries for visual representation.

---

# Project monorepo

This repository contains every GreenPal project. You can find my applications under the `apps` folder and the shared libraries under the `packages` folder. Please follow the `Setup` section of this guide if this is your first time working with this repository.

## **Setup**

Follow these steps to set up the project:

1. **Clone the Repository**
```bash
git clone https://github.com/AlainMk/green-pal-tracker.git
cd green-pal-tracker
```

```bash
dart pub global activate melos
```

## Run the project

You can run the project similar to the previous setup, by selecting `Run > Run without debugging` (`Ctrl + F5`) in VSCode. (Or it's `Start debugging` (`F5`) counterpart if you want to add breakpoints.)

To switch between projects which one to start up with this command you can navigate using the left action bar to the `Run and Debug` option (`Cmd + Shift + D`) and select the appropriate project from the dropdown on the top of the tab.

## Commands

The monorepo management tool `melos` enables us to run a lot of useful commands running operations on every project inside this repository.

To list the available commands run:
```bash
melos run
```
### Most important commands

Run the tracker app (replace `YOUR_API_URL` with your API URL):
```bash 
melos run:tracker -- --dart-define=BASE_URL=`YOUR_API_URL`
```

Run the UI shared app:
```bash
melos run:ui
```

Run the linter on the projects:
```bash
melos analyze
```

Run the formatter on the projects:
```bash
melos format
```

Run the test suite on the projects:
```bash
melos test
```

## **Table of Contents of the Tracker App**
1. [Features](#features)
2. [Architecture](#architecture)
3. [Technologies Used](#technologies-used)
4. [Usage](#usage)
5. [Folder Structure](#folder-structure)

---

## **Features**
- **Live Solar Data Monitoring**: Fetch real-time solar energy generation data using an API.
- **Interactive Visualizations**: Displays data in a line chart with interactive trackball behavior.
- **State Persistence**: Caches previously fetched data to avoid redundant API calls.
- **Unit Toggle**: Switch between Watt (W) and Kilowatt (kW) for energy units.
- **Date Navigation**: View historical data by selecting a date from a calendar.
- **Error Handling**: Displays error messages and allows retries for failed API calls.
- **Pull-to-Refresh**: Refresh data by pulling down the screen.
- **Dark Mode Support**: Supports both light and dark themes.
- **Data polling**: Polls the API every 15 seconds for real-time data updates.

---

## **Architecture**
The project follows **Clean Architecture** principles with a modular structure:

1. **Presentation Layer**
    - Widgets and UI components (e.g., `SolarScreen`, `GraphHeader`, `EnergyLineChart`).
    - `Bloc` for managing state transitions (`SolarBloc`, `HomeBloc`, `BatteryBloc`).

2. **Domain Layer**
    - `GraphRepository` for business logic and interaction between data and presentation layers.

3. **Data Layer**
    - `GraphApi` for remote data fetching using Dio.
    - `GraphLocalDB` for local caching using Hive.

---

## **Technologies Used**
- **Flutter**: Framework for building cross-platform mobile applications.
- **Dio**: HTTP client for API requests.
- **Hive**: Lightweight database for local caching.
- **Syncfusion Charts**: For rendering interactive line charts.
- **Flutter Bloc**: State management library.
- **Mockito**: For unit test mocking.
- **Mocktail**: For widget test mocking.
- **get_it**: Dependency injection.

---

## **Usage**
1. **Open the app to view real-time solar generation data.**
2. **Use the toggle switch to view data in W or kW.**
3. **Tap the calendar icon to select a specific date for historical data.**
4. **Pull to refresh the data.**
5. **In case of errors, retry by tapping the retry button on the error screen.**
6. **Navigate to the house screen to view house data.**
7. **Navigate to the battery screen to view battery data.**

---

## **Folder Structure**
lib/
├── graph/
│   ├── data/
│   │   ├── models/                # GraphData model
│   │   ├── repository/            # GraphRepository for data logic
│   │   ├── api/                   # GraphApi for remote data fetching
│   │   └── db/                    # GraphLocalDB for local caching 
│   ├── ui/
│   │   ├── blocs/                 # SolarBloc, HomeBloc, BatteryBloc
│           ├── shared/            # Shared bloc logic for a cleaner reusability on the multiple blocs
│   │   ├── pages/                 # SolarScreen, HomeScreen, BatteryScreen
│   │   └── widgets/               # Shared UI components (GraphHeader, EnergyLineChart)
├── main/main_screen.dart          # Main screen with bottom navigation
├── shared/
│   ├── manager/                   # CacheManager for handling local caching
│   ├── models/                    # Shared models like RepositoryError
│   ├── services/                  # Shared services like ConfigService
│   └── di.dart                    # Dependency injection setup
test/
├── ui/
│   ├── solar_screen_test.dart     # Widget tests for SolarScreen
├── data/
│   ├── graph_datasource_test.dart # Unit tests for GraphDataSource
├── test_helpers/
│   ├── mocks.dart                 # Mocktail mocks for testing
│   ├── test_data.dart             # Test data helpers
