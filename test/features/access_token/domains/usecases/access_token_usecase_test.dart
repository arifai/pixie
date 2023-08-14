import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';

import '../../../../mocks/access_token/mock_access_token_repository.dart';

void main() {
  late MockAccessTokenRepository repo;
  late SaveAccessTokenUseCase saveUseCase;
  late GetAccessTokenUseCase getUseCase;
  late RemoveAccessTokenUseCase removeUseCase;

  setUp(() {
    repo = MockAccessTokenRepository();
    saveUseCase = SaveAccessTokenUseCase(repo);
    getUseCase = GetAccessTokenUseCase(repo);
    removeUseCase = RemoveAccessTokenUseCase(repo);
  });

  group('AccessTokenUseCase', () {
    final Faker faker = Faker();
    final String jwt = faker.jwt.expired();
    final AccessTokenParams params = AccessTokenParams(
      accessToken: jwt,
      refreshToken: jwt,
    );

    test('should save the access token locally', () {
      when(() => repo.save(params)).thenAnswer((_) => TaskEither.of(true));

      saveUseCase(params);

      verify(() => repo.save(params));
      verifyNoMoreInteractions(repo);
    });

    test('should get the access token', () async {
      when(() => repo.get()).thenAnswer((_) => TaskEither.of(jwt));

      final result = await getUseCase(const NoParams()).run();

      expect(result, equals(right(jwt)));

      verify(() => repo.get());
      verifyNoMoreInteractions(repo);
    });

    test('should remove the access token', () {
      when(() => repo.remove()).thenAnswer((_) => TaskEither.of(true));

      removeUseCase(const NoParams());

      verify(() => repo.remove());
      verifyNoMoreInteractions(repo);
    });

    test('should failure to save the access token locally', () async {
      when(() => repo.save(params))
          .thenAnswer((_) => TaskEither.left(const LocalFailure('')));

      final result = await saveUseCase(params).run();

      expect(result, equals(left(const LocalFailure(''))));

      verify(() => repo.save(params));
      verifyNoMoreInteractions(repo);
    });

    test('should failure to get the access token', () async {
      when(() => repo.get())
          .thenAnswer((_) => TaskEither.left(const LocalFailure('')));

      final result = await getUseCase(const NoParams()).run();

      expect(result, equals(left(const LocalFailure(''))));

      verify(() => repo.get());
      verifyNoMoreInteractions(repo);
    });

    test('should failure to remove the access token', () async {
      when(() => repo.remove())
          .thenAnswer((_) => TaskEither.left(const LocalFailure('')));

      final result = await removeUseCase(const NoParams()).run();

      expect(result, equals(left(const LocalFailure(''))));

      verify(() => repo.remove());
      verifyNoMoreInteractions(repo);
    });
  });
}
