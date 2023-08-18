import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';
import 'package:pixie/features/current_user/domains/repositories/current_user_repository.dart';

class GetCurrentUserUseCase extends UseCase<CurrentUserEntity, NoParams> {
  const GetCurrentUserUseCase(this._repository);

  final CurrentUserRepository _repository;

  @override
  TaskEither<Failure, CurrentUserEntity?> call(params) => _repository.get();
}
