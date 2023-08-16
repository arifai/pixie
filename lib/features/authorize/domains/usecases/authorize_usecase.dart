import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
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

class RegistrationUseCase extends UseCase<RegistrationEntity, RegisterParams> {
  const RegistrationUseCase(this._repository);

  final AuthorizeRepository _repository;

  @override
  TaskEither<Failure, RegistrationEntity?> call(params) =>
      _repository.registration(params);
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

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    required this.device,
    required this.ipAddress,
  });

  final String fullName;
  final String username;
  final String email;
  final String password;
  final String device;
  final String ipAddress;

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
      'device': device,
      'ipAddress': ipAddress,
    };
  }

  // coverage:ignore-start
  @override
  List<Object?> get props => [
        fullName,
        username,
        email,
        password,
        device,
        ipAddress,
      ];
  // coverage:ignore-end
}
