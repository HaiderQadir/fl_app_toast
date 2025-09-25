library fl_app_toast;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A Flutter library for customizable toasts with smooth animations,
/// supporting dynamic text/image sizes, toast types, positions, and overlay-based rendering.

enum ToastType { success, error, warning, info }

enum ToastPosition { top, center, bottom }

class FlAppToast {
  // Displays a customizable toast with smooth animations
  static void show(
      BuildContext context,
      String message, {
        Widget? icon,
        String? imagePath,
        ToastType type = ToastType.info,
        ToastPosition position = ToastPosition.bottom,
        Duration duration = const Duration(seconds: 3),
        Color? backgroundColor,
        Color? textColor,
        double borderRadius = 12.0,
        bool dismissible = true,
        Curve animationCurve = Curves.easeOutBack,
        double? textSize,
        double? imageSize,
      }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _FlAppToastWidget(
        message: message,
        icon: icon,
        imagePath: imagePath,
        type: type,
        position: position,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderRadius: borderRadius,
        duration: duration,
        dismissible: dismissible,
        animationCurve: animationCurve,
        textSize: textSize ?? 14.0,
        imageSize: imageSize ?? 20.0,
        onDismissed: () {
          overlayEntry.remove();
        },
      ),
    );
    overlay.insert(overlayEntry);
  }
}

class _FlAppToastWidget extends StatefulWidget {
  final String message;
  final Widget? icon;
  final String? imagePath;
  final ToastType type;
  final ToastPosition position;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final Duration duration;
  final bool dismissible;
  final Curve animationCurve;
  final double textSize;
  final double imageSize;
  final VoidCallback onDismissed;

  const _FlAppToastWidget({
    Key? key,
    required this.message,
    this.icon,
    this.imagePath,
    required this.type,
    required this.position,
    this.backgroundColor,
    this.textColor,
    required this.borderRadius,
    required this.duration,
    required this.dismissible,
    required this.animationCurve,
    required this.textSize,
    required this.imageSize,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<_FlAppToastWidget> createState() => _FlAppToastWidgetState();
}

class _FlAppToastWidgetState extends State<_FlAppToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _shadowAnimation;
  late Animation<double> _iconFadeAnimation;
  late Animation<double> _textFadeAnimation;

  // Sets up animations for a smooth toast entrance and exit
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: widget.animationCurve),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.position == ToastPosition.top ? -0.5 : 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.7, curve: widget.animationCurve),
      ),
    );

    _iconRotationAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _shadowAnimation = Tween<double>(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: widget.animationCurve),
      ),
    );

    _iconFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.7, curve: widget.animationCurve),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.8, curve: widget.animationCurve),
      ),
    );

    _controller.forward();

    if (widget.duration.inMilliseconds > 0) {
      Future.delayed(widget.duration, () async {
        if (mounted) {
          await _controller.reverse();
          widget.onDismissed();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the toast UI with animated effects
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color bgColor = widget.backgroundColor ?? Colors.grey[800]!;
    final Color txtColor = widget.textColor ?? Colors.white;

    final Widget? effectiveIcon = widget.icon ??
        (widget.imagePath != null
            ? _buildImageWidget(widget.imagePath!)
            : _getDefaultIcon(widget.type));

    final Alignment alignment;
    switch (widget.position) {
      case ToastPosition.top:
        alignment = Alignment.topCenter;
        break;
      case ToastPosition.center:
        alignment = Alignment.center;
        break;
      case ToastPosition.bottom:
        alignment = Alignment.bottomCenter;
        break;
    }

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !widget.dismissible,
        child: SafeArea(
          child: GestureDetector(
            onTap: widget.dismissible
                ? () async {
              await _controller.reverse();
              widget.onDismissed();
            }
                : null,
            child: Container(
              alignment: alignment,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Material(
                      elevation: _shadowAnimation.value,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      color: Colors.transparent,
                      child: Container(
                        constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 400),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius:
                          BorderRadius.circular(widget.borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: _shadowAnimation.value,
                              spreadRadius: _shadowAnimation.value / 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (effectiveIcon != null) ...[
                              FadeTransition(
                                opacity: _iconFadeAnimation,
                                child: RotationTransition(
                                  turns: _iconRotationAnimation,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                      colorScheme.surface.withOpacity(0.2),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: effectiveIcon,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            Flexible(
                              child: FadeTransition(
                                opacity: _textFadeAnimation,
                                child: Text(
                                  widget.message,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: txtColor,
                                    fontSize: widget.textSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  semanticsLabel: widget.message,
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
            ),
          ),
        ),
      ),
    );
  }

  // Picks a background color based on the toast type
  Color _getBackgroundColor(ColorScheme colorScheme, ToastType type) {
    switch (type) {
      case ToastType.success:
        return colorScheme.primaryContainer;
      case ToastType.error:
        return colorScheme.errorContainer;
      case ToastType.warning:
        return colorScheme.secondaryContainer;
      case ToastType.info:
      default:
        return Colors.grey[800]!;
    }
  }

  // Returns a default icon for the given toast type
  Widget? _getDefaultIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icon(Icons.check_circle_outline,
            size: widget.imageSize, color: Colors.white);
      case ToastType.error:
        return Icon(Icons.error_outline,
            size: widget.imageSize, color: Colors.white);
      case ToastType.warning:
        return Icon(Icons.warning_amber_outlined,
            size: widget.imageSize, color: Colors.white);
      case ToastType.info:
        return Icon(Icons.info_outline,
            size: widget.imageSize, color: Colors.white);
    }
  }

  // Loads an image or SVG for the toast icon
  Widget _buildImageWidget(String path) {
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: widget.imageSize,
        height: widget.imageSize,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        path,
        width: widget.imageSize,
        height: widget.imageSize,
        fit: BoxFit.contain,
      );
    }
  }
}
