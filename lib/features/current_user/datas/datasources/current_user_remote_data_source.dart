import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/networks/endpoints.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/features/current_user/datas/models/current_user_response.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';

abstract class CurrentUserRemoteDataSource {
  TaskEither<Failure, CurrentUserEntity?> get();
}

class CurrentUserRemoteDataSourceImp implements CurrentUserRemoteDataSource {
  const CurrentUserRemoteDataSourceImp(this._client);

  final Network _client;

  @override
  TaskEither<Failure, CurrentUserEntity?> get() {
    return _client.get(
      path: Endpoints.currentUser,
      converter: (resp) => CurrentUserResponse.fromMap(resp['result']),
    );
  }
}
