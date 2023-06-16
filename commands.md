# Riverpod
flutter pub add flutter_riverpod dev:custom_lint dev:riverpod_lint riverpod_annotation dev:build_runner dev:riverpod_generator

# Freezed
flutter pub add freezed_annotation
flutter pub add --dev build_runner
flutter pub add --dev freezed
<!-- # if using freezed to generate fromJson/toJson, also add: -->
flutter pub add json_annotation
flutter pub add --dev json_serializable

### in analysis_options.yaml add
analyzer:
  errors:
    invalid_annotation_target: ignore

### run
flutter pub run build_runner build

## Internet access on macOS app
add to macos/Runner/DebugProfile.entitlements and macos/Runner/Release.entitlements
```
<key>com.apple.security.network.client</key>
<true/>
```
