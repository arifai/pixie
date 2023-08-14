import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';

abstract class AccessTokenRepository {
  TaskEither<Failure, bool?> save(AccessTokenParams token);
  TaskEither<Failure, String?> get();
  TaskEither<Failure, bool?> remove();
}
