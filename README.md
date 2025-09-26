# FlAppToast

A Flutter library for displaying customizable, animated toast notifications in your Flutter applications. It supports dynamic text and image sizes, multiple toast types, customizable positions, and overlay-based rendering with smooth animations.

## Features

- **Customizable Toast Types**: Supports `success`, `error`, `warning`, and `info` toasts with default icons and background colors.
- **Flexible Positioning**: Display toasts at the `top`, `center`, or `bottom` of the screen.
- **Smooth Animations**: Includes fade, scale, slide, rotation, and shadow animations for a polished user experience.
- **Custom Icons and Images**: Use custom widgets, SVG, or raster images for toast icons.
- **Dismissible Toasts**: Allow users to dismiss toasts by tapping, with configurable duration.
- **Dynamic Styling**: Customize background color, text color, border radius, text size, and image size.
- **Overlay-Based Rendering**: Toasts are displayed using Flutter's `Overlay` for non-intrusive integration.

## Installation

Add `fl_app_toast` to your `pubspec.yaml`:

```yaml
dependencies:
  fl_app_toast: ^1.0.1
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

Show a toast by calling the `FlAppToast.show` method:

```dart
FlAppToast.show(
  context,
  'This is a toast message!',
  type: ToastType.success,
  position: ToastPosition.bottom,
  duration: Duration(seconds: 3),
  backgroundColor: Colors.green,
  textColor: Colors.white,
  borderRadius: 8.0,
  textSize: 16.0,
  imageSize: 24.0,
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
FlAppToast.show(
  context,
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
FlAppToast.show(
  context,
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
- **Scale**: Scales the toast from 70% to 100% size.
- **Slide**: Slides in from the top or bottom based on the `position`.
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

- Ensure the `BuildContext` passed to `FlAppToast.show` has access to an `Overlay`. Typically, this is the context from a widget within a `MaterialApp` or `WidgetsApp`.
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