import 'package:get_it/get_it.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/cores/networks/network_imp.dart';

GetIt di = GetIt.instance;

Future<void> setup([bool test = false]) async {
  if (test) {
    di.reset();
    _utils();
  } else {
    _utils();
  }
}

void _utils() {
  di.registerLazySingleton<Network>(() => NetworkImp());
}
