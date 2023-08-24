// coverage:ignore-file

import 'package:flutter/widgets.dart';

/// {@template app_navigator}
/// Custom [Navigator] with out context.
/// {@endtemplate}
class AppNavigator {
  /// {@macro app_navigator}
  AppNavigator();

  /// Global navigator key
  GlobalKey<NavigatorState> get navigatorKey => _navKey;

  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  /// Same as `pop()`
  void pop({Object? argument}) {
    return _navKey.currentState?.pop(argument);
  }

  /// Same as `popAndPushNamed()`
  Future<dynamic> popTo(String routeName, {Object? arguments}) {
    return _navKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  /// Same as `pushNamed()`
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return _navKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  /// Same as `pushReplacementNamed()`
  Future<dynamic> moveTo(
    String routeName, {
    Object? arguments,
    Object? result,
  }) {
    return _navKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  /// Same as `pushNamedAndRemoveUntil()`
  Future<dynamic> pushTo(String routeName, {Object? arguments}) {
    return _navKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
