/// FlAppToast - A simple library to show toasts in Flutter.
library fl_app_toast;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'enums.dart';

export 'enums.dart';

/// The main class to show toasts.
class FlAppToast {
  /// Private constructor.
  FlAppToast._();

  /// The navigator key used to show toasts without using context.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Shows a toast message on the screen.
  /// 
  /// You can call this from anywhere, even inside initState.
  /// 
  /// New additions:
  /// * **Context-less**: Works without [context] if [navigatorKey] is set in MaterialApp.
  /// * **InitState Safe**: Automatically waits for the UI to be ready if called during startup.
  /// * **Text-only**: Set [showIcon] to false to show only the message.
  ///
  /// Parameters:
  /// * [message]: The text to show.
  /// * [context]: Optional context.
  /// * [type]: Type of the toast.
  /// * [position]: Where to show it.
  /// * [duration]: How long it stays.
  /// * [backgroundColor]: Background color.
  /// * [textColor]: Text color.
  /// * [iconColor]: Icon color.
  /// * [borderRadius]: Rounded corners size.
  /// * [dismissible]: If true, you can tap to close it.
  /// * [textSize]: Size of the text.
  /// * [imageSize]: Size of the icon.
  /// * [icon]: A custom widget for the icon.
  /// * [imagePath]: Path to an image or SVG file.
  /// * [showIcon]: Whether to show the icon (default is true).
  static void showToast(String message, {
    BuildContext? context,
    ToastType type = ToastType.info,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double borderRadius = 12.0,
    bool dismissible = true,
    double? textSize,
    double? imageSize,
    Widget? icon,
    String? imagePath,
    bool showIcon = true,
  }) {

    // Try to show immediately
    final success = _tryShow(
      context: context,
      message: message,
      type: type,
      position: position,
      duration: duration,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      borderRadius: borderRadius,
      dismissible: dismissible,
      textSize: textSize,
      imageSize: imageSize,
      icon: icon,
      imagePath: imagePath,
      showIcon: showIcon,
    );

    // If it doesn't work, try again after the UI loads
    if (!success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tryShow(
          context: context,
          message: message,
          type: type,
          position: position,
          duration: duration,
          backgroundColor: backgroundColor,
          textColor: textColor,
          iconColor: iconColor,
          borderRadius: borderRadius,
          dismissible: dismissible,
          textSize: textSize,
          imageSize: imageSize,
          icon: icon,
          imagePath: imagePath,
          showIcon: showIcon,
        );
      });
    }
  }

  static bool _tryShow({
    BuildContext? context,
    required String message,
    required ToastType type,
    required ToastPosition position,
    required Duration duration,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    required double borderRadius,
    required bool dismissible,
    double? textSize,
    double? imageSize,
    Widget? icon,
    String? imagePath,
    required bool showIcon,
  }) {
    OverlayState? overlay;

    // 1. Use the context to look for the overlay
    if (context != null && context.mounted) {
      overlay = Overlay.maybeOf(context, rootOverlay: true);
    }

    // 2. Use navigatorKey to look for the overlay
    overlay ??= navigatorKey.currentState?.overlay;

    // 3. If nothing else works, look through the whole widget tree to find an Overlay
    if (overlay == null) {
      final rootElement = WidgetsBinding.instance.rootElement;
      if (rootElement != null) {
        overlay = _findOverlayInTree(rootElement);
      }
    }

    if (overlay == null) return false;

    _insertOverlay(
      overlay,
      message,
      icon,
      imagePath,
      type,
      position,
      backgroundColor,
      textColor,
      iconColor,
      borderRadius,
      duration,
      dismissible,
      textSize,
      imageSize,
      showIcon,
    );
    return true;
  }

  static OverlayState? _findOverlayInTree(Element element) {

    if (element is StatefulElement && element.state is OverlayState) {
      return element.state as OverlayState;
    }
    OverlayState? found;
    element.visitChildren((child) {
      found ??= _findOverlayInTree(child);
    });
    return found;
  }

  static void _insertOverlay(OverlayState overlay,
      String message,
      Widget? icon,
      String? imagePath,
      ToastType type,
      ToastPosition position,
      Color? backgroundColor,
      Color? textColor,
      Color? iconColor,
      double borderRadius,
      Duration duration,
      bool dismissible,
      double? textSize,
      double? imageSize,
      bool showIcon,) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) =>
          _FlAppToastWidget(
            message: message,
            icon: icon,
            imagePath: imagePath,
            type: type,
            position: position,
            backgroundColor: backgroundColor,
            textColor: textColor,
            iconColor: iconColor,
            borderRadius: borderRadius,
            duration: duration,
            dismissible: dismissible,
            textSize: textSize ?? 14.0,
            imageSize: imageSize ?? 20.0,
            showIcon: showIcon,
            onDismissed: () {
              if (overlayEntry.mounted) {
                overlayEntry.remove();
              }
            },
          ),
    );

    overlay.insert(overlayEntry);
  }
}

// ==================== Private Toast Widget ====================

class _FlAppToastWidget extends StatefulWidget {
  final String message;
  final Widget? icon;
  final String? imagePath;
  final ToastType type;
  final ToastPosition position;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double borderRadius;
  final Duration duration;
  final bool dismissible;
  final double textSize;
  final double imageSize;
  final bool showIcon;
  final VoidCallback onDismissed;

  const _FlAppToastWidget({
    required this.message,
    this.icon,
    this.imagePath,
    required this.type,
    required this.position,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    required this.borderRadius,
    required this.duration,
    required this.dismissible,
    required this.textSize,
    required this.imageSize,
    required this.showIcon,
    required this.onDismissed,
  });

  @override
  State<_FlAppToastWidget> createState() => _FlAppToastWidgetState();
}

class _FlAppToastWidgetState extends State<_FlAppToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.position == ToastPosition.top ? -0.2 : 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(widget.duration, () async {
      if (mounted) {
        await _controller.reverse();
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Color txtColor = widget.textColor ?? Colors.white;
    final Color bgColor = widget.backgroundColor ?? const Color(0xD9000000);

    // Logic to determine if we should show an icon
    final Widget? effectiveIcon = widget.icon ??
        (widget.imagePath != null
            ? _buildImageWidget(widget.imagePath!)
            : (widget.showIcon ? _getDefaultIcon(widget.type, widget.iconColor ?? Colors.white) : null));

    return Positioned(
      top: widget.position == ToastPosition.top ? 60 : (widget.position == ToastPosition.center ? 0 : null),
      bottom: widget.position == ToastPosition.bottom ? 60 : (widget.position == ToastPosition.center ? 0 : null),
      left: 20,
      right: 20,
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (effectiveIcon != null) ...[
                      effectiveIcon,
                      const SizedBox(width: 12),
                    ],
                    Flexible(
                      child: Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: txtColor,
                          fontSize: widget.textSize,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String path) {

    if (path.endsWith('.svg')) {
      return SvgPicture.asset(path, width: widget.imageSize, height: widget.imageSize);
    }
    return Image.asset(path, width: widget.imageSize, height: widget.imageSize);
  }

  Widget? _getDefaultIcon(ToastType type, Color color) {
    IconData icon;

    switch (type) {
      case ToastType.success:
        icon = Icons.check_circle;
        break;
      case ToastType.error:
        icon = Icons.error;
        break;
      case ToastType.warning:
        icon = Icons.warning;
        break;
      case ToastType.info:
        icon = Icons.info;
        break;
    }

    return Icon(icon, color: color, size: widget.imageSize);
  }
}
