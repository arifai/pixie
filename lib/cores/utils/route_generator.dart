// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixie/cores/constants/app_routes.dart';
import 'package:pixie/cores/utils/di.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';
import 'package:pixie/features/authorize/presentations/pages/authorize_page.dart';

/// {@template route_generator}
/// Custom route app system.
/// {@endtemplate}
class RouteGenerator {
  /// {@macro route_generator}
  const RouteGenerator(this._settings);

  final RouteSettings _settings;

  /// Generate all routes
  Route<dynamic>? gen() {
    return MaterialPageRoute(
      builder: (_) {
        // final Object? args = _settings.arguments;

        switch (_settings.name) {
          case AppRoutes.authorize:
            return BlocProvider(
              create: (_) => di<AuthorizeBloc>(),
              child: const AuthorizePage(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
