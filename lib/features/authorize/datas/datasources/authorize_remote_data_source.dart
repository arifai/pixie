import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/networks/endpoints.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/features/access_token/datas/models/access_token_response.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/datas/models/registration_response.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

abstract class AuthorizeRemoteDataSource {
  TaskEither<Failure, AccessTokenEntity?> authorize(AuthParams params);
  TaskEither<Failure, RegistrationEntity?> unauthorize(String? token);
  TaskEither<Failure, RegistrationEntity?> registration(RegisterParams params);
  TaskEither<Failure, RegistrationEntity?> activation(ActivationParams params);
}

class AuthorizeRemoteDataSourceImp implements AuthorizeRemoteDataSource {
  const AuthorizeRemoteDataSourceImp(this._client);

  final Network _client;

  @override
  TaskEither<Failure, AccessTokenEntity?> authorize(params) {
    return _client.post(
      path: Endpoints.authorize,
      converter: (resp) => AccessTokenResponse.fromMap(resp),
      body: params.toMap(),
    );
  }

  @override
  TaskEither<Failure, RegistrationEntity?> unauthorize(token) {
    return _client.post(
      path: Endpoints.unauthorize,
      converter: (resp) => RegistrationResponse.fromMap(resp),
      body: {'accessToken': token},
    );
  }

  @override
  TaskEither<Failure, RegistrationEntity?> registration(params) {
    return _client.post(
      path: Endpoints.registration,
      converter: (resp) => RegistrationResponse.fromMap(resp),
      body: params.toMap(),
    );
  }

  @override
  TaskEither<Failure, RegistrationEntity?> activation(params) {
    return _client.post(
      path: Endpoints.activation,
      converter: (resp) => RegistrationResponse.fromMap(resp),
      body: params.toMap(),
    );
  }
}
