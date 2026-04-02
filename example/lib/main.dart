import 'package:flutter/material.dart';
import 'package:fl_app_toast/fl_app_toast.dart';

void main() {
  // Step 1: Assign your navigatorKey to FlAppToast to enable context-less toasts
  FlAppToast.navigatorKey = GlobalKey<NavigatorState>();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Step 2: Set the navigatorKey here
      navigatorKey: FlAppToast.navigatorKey,
      title: 'FlAppToast Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState() {
    super.initState();
    
    // Step 3: You can now safely call toasts in initState!
    FlAppToast.showToast(
      "Hello! This toast was called from initState.",
      type: ToastType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlAppToast Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FlAppToast.showToast(
                  "Success Toast!",
                  type: ToastType.success,
                  position: ToastPosition.top,
                );
              },
              child: const Text("Show Success (Top)"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FlAppToast.showToast(
                  "Error Toast!",
                  type: ToastType.error,
                  position: ToastPosition.center,
                );
              },
              child: const Text("Show Error (Center)"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FlAppToast.showToast(
                  "Default Info Toast (Bottom)",
                );
              },
              child: const Text("Show Info (Bottom)"),
            ),
          ],
        ),
      ),
    );
  }
}
