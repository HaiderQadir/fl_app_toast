/// FlAppToast - A simple library to show toasts in Flutter.

/// The type of toast to show.
enum ToastType { 
  /// Success toast.
  success, 
  /// Error toast.
  error, 
  /// Warning toast.
  warning, 
  /// Info toast.
  info 
}

/// Where the toast will show up on the screen.
enum ToastPosition { 
  /// Shows at the top.
  top, 
  /// Shows in the middle.
  center, 
  /// Shows at the bottom.
  bottom 
}
