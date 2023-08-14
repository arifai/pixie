import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/access_token/domains/repositories/access_token_repository.dart';

class SaveAccessTokenUseCase extends UseCase<bool, AccessTokenParams> {
  const SaveAccessTokenUseCase(this._repository);

  final AccessTokenRepository _repository;

  @override
  TaskEither<Failure, bool?> call(AccessTokenParams params) =>
      _repository.save(params);
}

class GetAccessTokenUseCase extends UseCase<String, NoParams> {
  const GetAccessTokenUseCase(this._repository);

  final AccessTokenRepository _repository;

  @override
  TaskEither<Failure, String?> call(NoParams params) => _repository.get();
}

class RemoveAccessTokenUseCase extends UseCase<bool, NoParams> {
  const RemoveAccessTokenUseCase(this._repository);

  final AccessTokenRepository _repository;

  @override
  TaskEither<Failure, bool?> call(NoParams params) => _repository.remove();
}

class AccessTokenParams extends Equatable {
  const AccessTokenParams({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> fromMap() {
    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
