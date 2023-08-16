import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/datas/datasources/authorize_remote_data_source.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
import 'package:pixie/features/authorize/domains/repositories/authorize_repository.dart';

class AuthorizeRepositoryImp implements AuthorizeRepository {
  const AuthorizeRepositoryImp(this._dataSource);

  final AuthorizeRemoteDataSource _dataSource;

  @override
  TaskEither<Failure, AccessTokenEntity?> authorize(params) =>
      _dataSource.authorize(params);

  @override
  TaskEither<Failure, AccessTokenEntity?> unauthorize(token) =>
      _dataSource.unauthorize(token);

  @override
  TaskEither<Failure, RegistrationEntity?> registration(params) =>
      _dataSource.registration(params);
}
