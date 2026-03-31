# FlAppToast

A Flutter library for displaying customizable, animated toast notifications in your Flutter applications. It supports dynamic text and image sizes, multiple toast types, customizable positions, and overlay-based rendering with smooth animations.

## Features

- **Context-less Support**: Show toasts from anywhere (Services, ViewModels, etc.) without passing `BuildContext`.
- **InitState Ready**: Safely call `showToast` inside `initState`; the library automatically waits for the first frame.
- **Robust Overlay Discovery**: Automatically finds the `Overlay` in your widget tree even if `navigatorKey` isn't set.
- **Customizable Toast Types**: Supports `success`, `error`, `warning`, and `info` toasts with default icons.
- **Flexible Positioning**: Display toasts at the `top`, `center`, or `bottom`.
- **Smooth Animations**: High-performance fade, scale, and slide transitions.
- **Custom Icons and Images**: Full support for custom widgets and SVG assets.


## Screenshots

<p align="center">
  <img src="screenshots/flapptoast_ss (1).png" alt="Image 1" width="250"/>
  <img src="screenshots/flapptoast_ss (2).png" alt="Image 2" width="250"/>
  <img src="screenshots/flapptoast_ss (3).png" alt="Image 3" width="250"/>
</p>

<p align="center">
  <img src="screenshots/flapptoast_ss (4).png" alt="Image 4" width="250"/>
  <img src="screenshots/flapptoast_ss (5).png" alt="Image 5" width="250"/>
</p>


## Installation

Add `fl_app_toast` to your `pubspec.yaml`:

```yaml
dependencies:
  fl_app_toast: ^2.1.2
```

Run the following command to install the package:

```bash
flutter pub get
```

## Usage

Import the package in your Dart file:

```dart
import 'package:fl_app_toast/fl_app_toast.dart';
```

Show a toast by calling the `FlAppToast.showToast` method:

```dart
FlAppToast.showToast(
  'This is a toast message!',
  type: ToastType.success,
  position: ToastPosition.bottom,
  duration: Duration(seconds: 3),
  backgroundColor: Colors.black,
  textColor: Colors.white,
  borderRadius: 20.0,
  textSize: 12.0,
  imageSize: 20.0,
);
```

### Parameters

| Parameter          | Type              | Description                                                                 | Default Value                     |
|--------------------|-------------------|-----------------------------------------------------------------------------|-----------------------------------|
| `context`          | `BuildContext`    | The build context for overlay rendering.                                    | Required                          |
| `message`          | `String`          | The message to display in the toast.                                        | Required                          |
| `icon`             | `Widget?`         | Custom widget for the toast icon.                                           | `null`                            |
| `imagePath`        | `String?`         | Path to an image or SVG file for the toast icon.                            | `null`                            |
| `type`             | `ToastType`       | Type of toast: `success`, `error`, `warning`, or `info`.                    | `ToastType.info`                  |
| `position`         | `ToastPosition`   | Position of the toast: `top`, `center`, or `bottom`.                        | `ToastPosition.bottom`            |
| `duration`         | `Duration`        | Duration the toast is displayed before auto-dismissing.                     | `Duration(seconds: 3)`            |
| `backgroundColor`  | `Color?`          | Background color of the toast.                                              | Theme-based or `Colors.grey[800]` |
| `textColor`        | `Color?`          | Text color of the toast message.                                            | `Colors.white`                    |
| `borderRadius`     | `double`          | Border radius of the toast container.                                       | `12.0`                            |
| `dismissible`      | `bool`            | Whether the toast can be dismissed by tapping.                              | `true`                            |
| `animationCurve`   | `Curve`           | Animation curve for toast transitions.                                      | `Curves.easeOutBack`              |
| `textSize`         | `double?`         | Font size of the toast message.                                             | `14.0`                            |
| `imageSize`        | `double?`         | Size of the toast icon or image.                                            | `20.0`                            |

### Example with Custom Icon

```dart
FlAppToast.showToast(
  'Success! Operation completed.',
  type: ToastType.success,
  icon: Icon(Icons.star, color: Colors.yellow, size: 24.0),
  position: ToastPosition.center,
  duration: Duration(seconds: 5),
  backgroundColor: Colors.blue,
);
```

### Example with SVG Image

```dart
FlAppToast.showToast(
  'Warning: Check your input.',
  type: ToastType.warning,
  imagePath: 'assets/warning.svg',
  position: ToastPosition.top,
  textSize: 18.0,
  imageSize: 30.0,
);
```

## Dependencies

This library depends on the following packages:

- `flutter`: The core Flutter framework.
- `flutter_svg`: For rendering SVG images as toast icons.

Ensure these dependencies are included in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^2.0.0
```

## Customization

### Toast Types and Default Icons

The library provides four toast types, each with a default icon:

- **Success**: `Icons.check_circle_outline`
- **Error**: `Icons.error_outline`
- **Warning**: `Icons.warning_amber_outlined`
- **Info**: `Icons.info_outline`

You can override the default icon with a custom `Widget` or an image (SVG or raster) using the `icon` or `imagePath` parameters.

### Animation Effects

The toast includes the following animations:

- **Fade**: Smoothly fades in and out.
- **Scale**: Subtle bounce effect (80% to 100%).
- **Slide**: Gentle slide-in from the top or bottom.
- **Icon Rotation**: Subtle rotation effect for the icon.
- **Shadow**: Dynamic shadow elevation for depth.
- **Icon/Text Fade**: Staggered fade-in for the icon and text.

The animation curve can be customized using the `animationCurve` parameter (defaults to `Curves.easeOutBack`).

### Styling

- **Background Color**: Defaults to the theme's `primaryContainer`, `errorContainer`, `secondaryContainer`, or `Colors.grey[800]` based on the toast type. Override with `backgroundColor`.
- **Text Color**: Defaults to `Colors.white`. Override with `textColor`.
- **Border Radius**: Defaults to `12.0`. Override with `borderRadius`.
- **Text Size**: Defaults to `14.0`. Override with `textSize`.
- **Image Size**: Defaults to `20.0`. Override with `imageSize`.

## Notes

- If using SVG images, ensure the `flutter_svg` package is correctly configured and the SVG assets are included in your `pubspec.yaml`.
- The toast is rendered using an `OverlayEntry`, making it non-intrusive and compatible with most Flutter layouts.
- The toast is constrained to a minimum width of 100 and a maximum width of 400 pixels to ensure readability.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the project's GitHub repository.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.