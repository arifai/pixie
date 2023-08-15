import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';

abstract class AuthorizeRemoteDataSource {
  TaskEither<Failure, AccessTokenEntity?> authorize();
  TaskEither<Failure, void> unauthorize(String? token);
}
