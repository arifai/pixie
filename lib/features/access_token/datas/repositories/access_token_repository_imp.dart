import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/datas/datasource/access_token_local_data_source.dart';
import 'package:pixie/features/access_token/domains/repositories/access_token_repository.dart';

class AccessTokenRepositoryImp implements AccessTokenRepository {
  AccessTokenRepositoryImp(this.dataSource);

  final AccessTokenLocalDataSource dataSource;

  @override
  TaskEither<Failure, bool> save(String token) {
    return TaskEither.tryCatch(
      () async => await dataSource.save(token).run(),
      (e, _) => LocalFailure('Error while save access token: $e'),
    );
  }

  @override
  TaskEither<Failure, bool> remove() {
    return TaskEither.tryCatch(
      () async => await dataSource.remove().run(),
      (e, _) => LocalFailure('Error while remove access token: $e'),
    );
  }

  @override
  TaskEither<Failure, String?> get() {
    return TaskEither.tryCatch(
      () async => dataSource.get(),
      (e, _) => LocalFailure('Error get access token: $e'),
    );
  }
}
