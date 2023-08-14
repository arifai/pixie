# Features

Organizes the application into different features.

Each feature is separated into its own directory under `features/`, allowing you to isolate the logic and UI for each feature separately. This approach can facilitate teamwork and make it easier to manage larger application components.

## Inside The features Folder

- `datas/` - Contains the implementation of repositories, models and data sources.
- `domains/` - Contains core business entities and rules.
- `presentations/` - Contains components related to UI and business logic.

# Folder Structure

```
features/
└── feature_one/
    ├── datas/
    │   ├── datasources
    │   ├── models
    │   └── repositories
    ├── domains/
    │   ├── entities
    │   ├── repositories
    │   └── usecases
    └── presentations/
        ├── blocs
        ├── cubits
        ├── pages
        └── widgets
```