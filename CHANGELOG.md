# Changelog

## 2.2.0
- **New Feature**: Added support for text-only toasts. Use the `showIcon: false` flag to hide icons.
- Added full DartDoc comments for the public API to improve pub.dev score.
- Added a package example in the `example/` directory.
- Small internal cleanups and performance improvements.

## 2.1.2 / 2.1.1 / 2.1.0
- Documentation updates and improvements.

## 2.0.0
- Major updates to the library.
- Added context-less support via `FlAppToast.navigatorKey`.
- Added automatic `Overlay` discovery in the widget tree.
- Fixed issue where toasts would not show when called from `initState`.
- Added automatic retry with `addPostFrameCallback` for early calls.
- Simplified `showToast` API for easier use.

## 1.0.2
- Added screenshots in markdown files.

## 1.0.1
- Updated documentation in `README.md` with comprehensive usage instructions, parameter details, and examples.
- Added detailed sections for features, installation, customization, and dependencies in `README.md`.
- Fixed minor typos and improved clarity in markdown files.

## 1.0.0
- Initial release of `fl_app_toast`.
- Introduced customizable toast notifications with support for multiple toast types: `success`, `error`, `warning`, and `info`.
- Added flexible positioning options: `top`, `center`, and `bottom`.
- Implemented smooth animations including fade, scale, slide, icon rotation, and shadow effects for enhanced user experience.
- Supported dynamic text and image sizes for adaptable UI integration.
- Enabled custom icons via widgets or image assets (SVG and raster formats).
- Provided options for customizable background color, text color, border radius, and animation curves.
- Integrated overlay-based rendering for non-intrusive toast display.
- Added dismissible toasts with configurable duration.
