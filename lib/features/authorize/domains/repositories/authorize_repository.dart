import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

abstract class AuthorizeRepository {
  TaskEither<Failure, AccessTokenEntity?> authorize(AuthParams params);
  TaskEither<Failure, RegistrationEntity?> unauthorize(String? token);
  TaskEither<Failure, RegistrationEntity?> registration(RegisterParams params);
  TaskEither<Failure, RegistrationEntity?> activation(ActivationParams params);
}
