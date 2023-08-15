import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/repositories/authorize_repository.dart';

class AuthorizeUseCase extends UseCase<AccessTokenEntity, AuthParams> {
  const AuthorizeUseCase(this._repository);

  final AuthorizeRepository _repository;

  @override
  TaskEither<Failure, AccessTokenEntity?> call(params) =>
      _repository.authorize(params);
}

class UnAuthorizeUseCase extends UseCase<AccessTokenEntity, String> {
  const UnAuthorizeUseCase(this._repository);

  final AuthorizeRepository _repository;

  @override
  TaskEither<Failure, AccessTokenEntity?> call(params) =>
      _repository.unauthorize(params);
}

class AuthParams extends Equatable {
  const AuthParams({required this.username, required this.password});

  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }

  // coverage:ignore-start
  @override
  List<Object?> get props => [username, password];
  // coverage:ignore-end
}
