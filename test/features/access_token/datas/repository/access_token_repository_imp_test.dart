import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/features/access_token/datas/repositories/access_token_repository_imp.dart';

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
    final String jwt = faker.jwt.expired();

    test('should save the access token locally and return true', () async {
      when(() => mockSource.save(any()).run()).thenAnswer((_) async => true);

      await repo.save(jwt).run();

      verify(() => mockSource.save(jwt).run());
    });

    test('should get the access token locally', () async {
      when(() => mockSource.get()).thenAnswer((_) => jwt);

      final result = await repo.get().run();

      verify(() => mockSource.get());
      expect(result, equals(right(jwt)));
    });

    test('should remove the access token locally and return true', () async {
      when(() => mockSource.remove().run()).thenAnswer((_) async => true);

      await repo.remove().run();

      verify(() => mockSource.remove().run());
    });

    test('should save empty string and return false', () async {
      when(() => mockSource.save(any()).run()).thenAnswer((_) async => false);

      await repo.save('').run();

      verify(() => mockSource.save('').run());
    });

    test('should get the access token but the result is null', () async {
      when(() => mockSource.get()).thenAnswer((_) => null);

      final result = await repo.get().run();

      verify(() => mockSource.get());
      expect(result, equals(right(null)));
    });

    test('should remove the access token locally and return false', () async {
      when(() => mockSource.remove().run()).thenAnswer((_) async => false);

      await repo.remove().run();

      verify(() => mockSource.remove().run());
    });
  });
}
