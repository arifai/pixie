import 'package:get_it/get_it.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/cores/networks/network_imp.dart';

GetIt di = GetIt.instance;

Future<void> setup([bool test = false]) async {
  if (test) {
    di.reset();
    _utils(test);
  } else {
    _utils();
  }
}

void _utils([bool test = false]) {
  di.registerLazySingleton<Network>(() => NetworkImp(test));
}
