import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

import '../../../../mocks/authorize/mock_authorize_repository.dart';

void main() {
  late MockAuthorizeRepository repo;
  late AuthorizeUseCase authUseCase;
  late UnAuthorizeUseCase unAuthUseCase;

  setUp(() {
    repo = MockAuthorizeRepository();
    authUseCase = AuthorizeUseCase(repo);
    unAuthUseCase = UnAuthorizeUseCase(repo);
  });

  group('AuthorizeUseCase', () {
    const AuthParams params = AuthParams(username: 'abc', password: 'abc');
    final Faker faker = Faker();
    final String jwt = faker.jwt.expired();
    final AccessTokenEntity data =
        AccessTokenEntity(accessToken: jwt, refreshToken: jwt);

    test('should return AccessTokenEntity when user authenticated', () async {
      when(() => repo.authorize(params)).thenAnswer((_) => TaskEither.of(data));

      final result = await authUseCase(params).run();

      expect(result, equals(right(data)));
      verify(() => repo.authorize(params));
      verifyNoMoreInteractions(repo);
    });

    test('should return NetworkFailure when user authenticate', () async {
      when(() => repo.authorize(params))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await authUseCase(params).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => repo.authorize(params));
      verifyNoMoreInteractions(repo);
    });

    test('should return null when user unauthenticated', () async {
      when(() => repo.unauthorize(any()))
          .thenAnswer((_) => TaskEither.of(null));

      final result = await unAuthUseCase('').run();

      expect(result, equals(right(null)));
      verify(() => repo.unauthorize(any()));
      verifyNoMoreInteractions(repo);
    });

    test('should return NetworkFailure when user unauthenticate', () async {
      when(() => repo.unauthorize(any()))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await unAuthUseCase('').run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => repo.unauthorize(any()));
      verifyNoMoreInteractions(repo);
    });
  });
}
