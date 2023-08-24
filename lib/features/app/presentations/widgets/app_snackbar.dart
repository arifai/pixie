import 'package:flutter/material.dart';

/// Default app [SnackBar] widget.
class AppSnackBar {
  AppSnackBar._();

  /// Snackbar widget for inside listener.
  static void show(
    BuildContext context, {
    required String? message,
    Color? bgColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.info_rounded, color: Colors.white),
            ),
            Flexible(
              child: Text(
                '$message',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Snackbar widget for inside builder. Please do not use `return` keyword
  /// or this is will be throw error.
  static dynamic build(
    BuildContext context, {
    required String? message,
    Color? bgColor = Colors.red,
  }) {
    return Future.delayed(Duration.zero, () => show(context, message: message));
  }
}
