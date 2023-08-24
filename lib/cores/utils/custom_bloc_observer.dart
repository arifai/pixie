import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('$transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('$change');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('$bloc, isClose: ${bloc.isClosed}');
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('Error: $error, StactTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
