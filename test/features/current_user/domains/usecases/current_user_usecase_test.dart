import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';
import 'package:pixie/features/current_user/domains/usecases/current_user_usecase.dart';

import '../../../../mocks/current_user/mock_current_user_repository.dart';

void main() {
  late MockCurrentUserRepository repo;
  late GetCurrentUserUseCase getUseCase;

  setUp(() {
    repo = MockCurrentUserRepository();
    getUseCase = GetCurrentUserUseCase(repo);
  });

  group('CurrentUserUseCase', () {
    final Faker faker = Faker();
    final CurrentUserEntity data = CurrentUserEntity(
      fullName: faker.person.name(),
      username: faker.internet.userName(),
      email: faker.internet.email(),
      avatar: faker.internet.httpsUrl(),
      isActive: true,
    );
    test('should return CurrentUserEntity when get current user successful',
        () async {
      when(() => repo.get()).thenAnswer((_) => TaskEither.of(data));

      final result = await getUseCase(null).run();

      expect(result, equals(right(data)));
      verify(() => repo.get());
      verifyNoMoreInteractions(repo);
    });

    test('should return NetworkFailure when failure to get current user',
        () async {
      when(() => repo.get())
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await getUseCase(null).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => repo.get());
      verifyNoMoreInteractions(repo);
    });
  });
}
