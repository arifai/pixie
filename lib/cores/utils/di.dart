// coverage:ignore-file

import 'package:get_it/get_it.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/cores/networks/network_imp.dart';
import 'package:pixie/features/authorize/datas/datasources/authorize_remote_data_source.dart';
import 'package:pixie/features/authorize/datas/repositories/authorize_repository_imp.dart';
import 'package:pixie/features/authorize/domains/repositories/authorize_repository.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';

GetIt di = GetIt.instance;

Future<void> setup([bool test = false]) async {
  if (test) {
    di.reset();
    _utils(test);
    _dataSources();
    _repositories();
    _useCases();
    _blocs();
  } else {
    _utils();
    _dataSources();
    _repositories();
    _useCases();
    _blocs();
  }
}

void _utils([bool test = false]) {
  di.registerLazySingleton<Network>(() => NetworkImp(test));
}

void _dataSources() {
  di.registerLazySingleton<AuthorizeRemoteDataSource>(
      () => AuthorizeRemoteDataSourceImp(di()));
}

void _repositories() {
  di.registerLazySingleton<AuthorizeRepository>(
      () => AuthorizeRepositoryImp(di()));
}

void _useCases() {
  di.registerLazySingleton(() => AuthorizeUseCase(di()));
  di.registerLazySingleton(() => UnAuthorizeUseCase(di()));
  di.registerLazySingleton(() => RegistrationUseCase(di()));
  di.registerLazySingleton(() => ActivationUseCase(di()));
}

void _blocs() {
  di.registerFactory(() => AuthorizeBloc(
        authUseCase: di(),
        unAuthUseCase: di(),
        registerUseCase: di(),
        activateUseCase: di(),
      ));
}
