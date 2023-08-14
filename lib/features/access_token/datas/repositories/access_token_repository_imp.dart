import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/datas/datasource/access_token_local_data_source.dart';
import 'package:pixie/features/access_token/domains/repositories/access_token_repository.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';

class AccessTokenRepositoryImp implements AccessTokenRepository {
  const AccessTokenRepositoryImp(this._dataSource);

  final AccessTokenLocalDataSource _dataSource;

  @override
  TaskEither<Failure, bool> save(AccessTokenParams token) {
    return TaskEither.tryCatch(
      () async => await _dataSource.save(token).run(),
      (e, _) => LocalFailure('Error while save access token: $e'),
    );
  }

  @override
  TaskEither<Failure, bool> remove() {
    return TaskEither.tryCatch(
      () async => await _dataSource.remove().run(),
      (e, _) => LocalFailure('Error while remove access token: $e'),
    );
  }

  @override
  TaskEither<Failure, String?> get() {
    return TaskEither.tryCatch(
      () async => _dataSource.get(),
      (e, _) => LocalFailure('Error get access token: $e'),
    );
  }
}
