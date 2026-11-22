# Changelog

All notable changes to this project are documented in this file.

## 2026-11-22

- Users→Settings integration_test resilient to CI network (no JSONPlaceholder required).
- Commit: Fix resilient Users→Settings Linux E2E on CI.
  - Poll for Users screen shell and open Settings without requiring JSONPlaceholder.
- Linux CI E2E runs under xvfb-run for headless GitHub Actions runners.

- Commit: Added Linux E2E integration tests and updated CI for desktop E2E.
  - integration_test smoke flow and Linux desktop target in CI.
- Commit: Use material_ui in integration_test to fix Flutter analyze deprecation.
  - Replaced legacy material.dart imports in integration tests for current Flutter stable analyze.

## 2026-11-14

- Commit: Updated toolchain to Dart SDK ^3.14.0, Gradle 9.5.0, Android Gradle Plugin 9.3.1 and Kotlin 2.4.20.
  - Migrated Material imports to material_ui and upgraded dependencies to their latest major versions.

## 2026-11-07

- Commit: Added url_launcher and a GitHub button to the About dialog.
  - Added the url_launcher ^6.3.3 dependency and a GitHub button inside the About dialog that opens https://github.com/william-franco.
- Commit: Updated project architecture under src/common/design.
  - Reorganized the shared design layer under src/common/design to keep the UI structure consistent.

## 2026-11-01

- Commit: Updated Dart SDK to ^3.13.7 and documented Gradle 9.3.1.
  - Aligned the Dart SDK constraint with the test_version reference and updated the README stack table with the Gradle version.

## 2026-10-10

- Commit: Updated Flutter SDK and dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-09-19

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-09-12

- Commit: Standardized README License section.
  - Improved the project documentation and clarified how the project is used or maintained.
- Commit: Updated project documentation.
  - Improved the project documentation and clarified how the project is used or maintained.

## 2026-09-07

- Commit: Fixed flutter analyze issues and updated CI checkout to Node 24.
  - Improved automated build, analysis, testing, or delivery checks for the project.
- Commit: Re-enabled flutter analyze in CI, propagated ResultPattern and added clean arch tests.
  - Improved automated build, analysis, testing, or delivery checks for the project.

## 2026-08-30

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-08-22

- Commit: Use == instead of identical in emitState.
  - Applied the change described by this commit and integrated it into the project history.
- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-08-16

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.
- Commit: Updated CI build system.
  - Improved automated build, analysis, testing, or delivery checks for the project.
- Commit: Updated dependencies and native folders.
  - Refreshed dependency versions and related build configuration to keep the project current.
- Commit: Updated CI build system and Android build configuration.
  - Improved automated build, analysis, testing, or delivery checks for the project.

## 2026-06-21

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-06-07

- Commit: Updated dependencies and native folders.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-05-24

- Commit: Updated dependencies and update StatePattern.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-05-09

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-04-11

- Commit: Added CI build system and unit tests.
  - Improved automated build, analysis, testing, or delivery checks for the project.

## 2026-03-29

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-03-22

- Commit: Updated dependencies and project documentation.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-03-15

- Commit: Added feature new approaches and code improvements.
  - Corrected behavior and improved implementation quality in the affected area.

## 2026-03-08

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2026-01-25

- Commit: Improvements and fixes.
  - Corrected behavior and improved implementation quality in the affected area.

## 2026-01-17

- Commit: Added feature StateManagement.
  - Introduced or expanded the functionality described by this commit.
- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-12-13

- Commit: Updated project documentation and dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-12-07

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-10-04

- Commit: Updated dependencies on android.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-09-24

- Commit: Update project architecture.
  - Refined the project structure and responsibilities to improve maintainability and extensibility.

## 2025-09-02

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-06-22

- Commit: Fixed routes usage.
  - Corrected behavior and improved implementation quality in the affected area.

## 2025-06-11

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-05-22

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-05-02

- Commit: Updated project documentation.
  - Improved the project documentation and clarified how the project is used or maintained.
- Commit: Added feature generic state.
  - Introduced or expanded the functionality described by this commit.
- Commit: Update project architecture.
  - Refined the project structure and responsibilities to improve maintainability and extensibility.

## 2025-02-20

- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-02-09

- Commit: Updated project documentation.
  - Improved the project documentation and clarified how the project is used or maintained.
- Commit: Updated dependencies.
  - Refreshed dependency versions and related build configuration to keep the project current.

## 2025-01-13

- Commit: Added feature settings.
  - Introduced or expanded the functionality described by this commit.
- Commit: Added feature users.
  - Introduced or expanded the functionality described by this commit.
- Commit: Added initial project architecture.
  - Refined the project structure and responsibilities to improve maintainability and extensibility.
- Commit: Initial commit.
  - Established the initial project structure and baseline implementation.
