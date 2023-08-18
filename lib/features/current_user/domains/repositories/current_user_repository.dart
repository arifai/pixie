import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';

abstract class CurrentUserRepository {
  TaskEither<Failure, CurrentUserEntity?> get();
}
