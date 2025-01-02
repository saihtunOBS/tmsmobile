# tmsmobile

A new Flutter project.

## Getting Started

Note:
- for any developers to read the code for the first time, it is reccomended to start from Authentication feature
- This flutter app use Bloc as statemanagement.
- This project use code generation, many of them are just for referencing, no need to edit by hand
- For example, if the file is "auth_repository.dart", the generated file will be "auth_repository.g.dart"
- To use the code generation:
  dart run build_runner build --delete-conflicting-outputs
- To generate translated text(also called "l10n"):
  dart run easy_localization:generate -S assets/l10n -f keys -O  lib/l10n -o locale_keys.g.dart
- to build .apk file:
    - flutter build apk --build-name=1.0 --build-number=1
- to build .aab file
    - flutter build appbundle --release
- built app location:
    - yourAppFolder/build/app/outputs/apk/release/app-release.apk
- "s" is very importance:
    - Employees = a list of Employee(),
    - Employee = a single Employee
- patch request has "application/merge-patch+json" as the Content-Type, this is different than the rest request method(get,post,put,delete) which use "application/ld+json"
- App architecture (file and folder structure) are design on feature based with (a) data layer (b) model (c) presentation. The presentation layer contain UI and statecontroller which manage the loading, error, and data state
- The code contains customised widgets that are reusesable.
