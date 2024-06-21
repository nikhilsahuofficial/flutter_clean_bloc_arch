import 'package:flutter/material.dart';

/// A simple splash screen widget displaying a centered CircularProgressIndicator.
///
/// This widget is typically used to indicate that the application is loading
/// or initializing when launched.
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
