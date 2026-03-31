import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fl_app_toast/fl_app_toast.dart';

void main() {
  testWidgets('FlAppToast library initializes and methods exist', (WidgetTester tester) async {
    // Basic sanity test to ensure the library is available and types are correct
    expect(ToastType.success, isNotNull);
    expect(ToastPosition.bottom, isNotNull);
    
    // Test that navigatorKey is accessible
    expect(FlAppToast.navigatorKey, isInstanceOf<GlobalKey<NavigatorState>>());
  });
}
