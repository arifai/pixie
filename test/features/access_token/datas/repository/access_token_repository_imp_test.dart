import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/features/access_token/datas/repositories/access_token_repository_imp.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';

import '../../../../mocks/access_token/mock_access_token_local_data_source.dart';

void main() {
  late MockAccessTokenLocalDataSource mockSource;
  late AccessTokenRepositoryImp repo;

  setUp(() {
    mockSource = MockAccessTokenLocalDataSource();
    repo = AccessTokenRepositoryImp(mockSource);
  });

  group('AccessTokenRepositoryImp', () {
    final Faker faker = Faker();
    final AccessTokenParams params = AccessTokenParams(
      accessToken: faker.jwt.expired(),
      refreshToken: faker.jwt.expired(expiresIn: DateTime.timestamp()),
    );
    const AccessTokenParams emptyParams =
        AccessTokenParams(accessToken: '', refreshToken: '');

    test('should save the access token locally', () async {
      when(() => mockSource.save(params).run()).thenAnswer((_) async => true);

      await repo.save(params).run();

      verify(() => mockSource.save(params).run());
    });

    test('should get the access token locally', () async {
      final String encoded = jsonEncode(params.toMap());

      when(() => mockSource.get()).thenAnswer((_) => encoded);

      final result = await repo.get().run();

      verify(() => mockSource.get());
      expect(result, equals(right(encoded)));
    });

    test('should remove the access token locally', () async {
      when(() => mockSource.remove().run()).thenAnswer((_) async => true);

      await repo.remove().run();

      verify(() => mockSource.remove().run());
    });

    test('should failed to save empty string', () async {
      when(() => mockSource.save(emptyParams).run())
          .thenAnswer((_) async => false);

      await repo.save(emptyParams).run();

      verify(() => mockSource.save(emptyParams).run());
    });

    test('should failed to get the access token', () async {
      when(() => mockSource.get()).thenAnswer((_) => null);

      final result = await repo.get().run();

      verify(() => mockSource.get());
      expect(result, equals(right(null)));
    });

    test('should failed to remove the access token locally', () async {
      when(() => mockSource.remove().run()).thenAnswer((_) async => false);

      await repo.remove().run();

      verify(() => mockSource.remove().run());
    });
  });
}
