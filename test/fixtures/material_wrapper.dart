import 'package:flutter/material.dart';
import 'package:pixie/cores/utils/app_navigator.dart';
import 'package:pixie/cores/utils/di.dart' as di;
import 'package:pixie/cores/utils/route_generator.dart';

import '../mocks/onboarding/mock_navigator_observer.dart';

Widget materialWrapper(Widget body) {
  final AppNavigator navigator = di.di<AppNavigator>();

  return MaterialApp(
    home: body,
    navigatorObservers: [MockNavigatorObserver()],
    navigatorKey: navigator.navigatorKey,
    onGenerateRoute: (settings) => RouteGenerator(settings).gen(),
  );
}
