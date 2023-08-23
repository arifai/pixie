import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixie/cores/constants/app_routes.dart';
import 'package:pixie/cores/constants/app_theme.dart';
import 'package:pixie/cores/utils/app_navigator.dart';
import 'package:pixie/cores/utils/custom_bloc_observer.dart';
import 'package:pixie/cores/utils/di.dart' as di;
import 'package:pixie/cores/utils/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSystem.lockPortrait();
  await di.setup();

  Bloc.observer = CustomBlocObserver();

  runApp(const PixieApp());
}

class PixieApp extends StatelessWidget {
  const PixieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = di.di<AppNavigator>();

    return MaterialApp(
      title: 'Pixie',
      theme: const AppTheme().base,
      navigatorKey: navigator.navigatorKey,
      initialRoute: AppRoutes.authorize,
      onGenerateRoute: (settings) => RouteGenerator(settings).gen(),
    );
  }
}

/// A class for handle [DeviceOrientation] app.
class AppSystem {
  const AppSystem._();

  /// Lock [DeviceOrientation] to portrait.
  static Future<void> lockPortrait() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }
}
