import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';

abstract class AccessTokenRepository {
  TaskEither<Failure, bool> save(String token);
  TaskEither<Failure, String?> get();
  TaskEither<Failure, bool> remove();
}
