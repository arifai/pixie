import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

import '../../../../mocks/authorize/mock_authorize_repository.dart';

void main() {
  late MockAuthorizeRepository repo;
  late AuthorizeUseCase authUseCase;
  late UnAuthorizeUseCase unAuthUseCase;
  late RegistrationUseCase registerUseCase;
  late ActivationUseCase activeUseCase;

  setUp(() {
    repo = MockAuthorizeRepository();
    authUseCase = AuthorizeUseCase(repo);
    unAuthUseCase = UnAuthorizeUseCase(repo);
    registerUseCase = RegistrationUseCase(repo);
    activeUseCase = ActivationUseCase(repo);
  });

  group('AuthorizeUseCase', () {
    final Faker faker = Faker();
    final String jwt = faker.jwt.expired();
    final RegistrationEntity registerData = RegistrationEntity(jwt);
    final AccessTokenEntity data =
        AccessTokenEntity(accessToken: jwt, refreshToken: jwt);
    AuthParams params = AuthParams(
      username: faker.internet.userName(),
      password: faker.internet.password(),
    );
    RegisterParams registerParams = RegisterParams(
      fullName: faker.person.name(),
      username: faker.internet.userName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      device: faker.internet.userAgent(),
      ipAddress: faker.internet.ipv4Address(),
    );
    ActivationParams activeParams = ActivationParams(
      token: faker.jwt.expired(),
      activationCode: faker.randomGenerator.integer(6),
    );

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

    test('should return RegistrationEntity when user registration successful',
        () async {
      when(() => repo.registration(registerParams))
          .thenAnswer((_) => TaskEither.of(registerData));

      final result = await registerUseCase(registerParams).run();

      expect(result, equals(right(registerData)));
      verify(() => repo.registration(registerParams));
      verifyNoMoreInteractions(repo);
    });

    test('should return NetworkFailure when user registration unsuccessful',
        () async {
      when(() => repo.registration(registerParams))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await registerUseCase(registerParams).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => repo.registration(registerParams));
      verifyNoMoreInteractions(repo);
    });

    test('should return null when user activation successful', () async {
      when(() => repo.activation(activeParams))
          .thenAnswer((_) => TaskEither.of(null));

      final result = await activeUseCase(activeParams).run();

      expect(result, equals(right(null)));
      verify(() => repo.activation(activeParams));
      verifyNoMoreInteractions(repo);
    });

    test('should return NetworkFailure when user activation unsuccessful',
        () async {
      when(() => repo.activation(activeParams))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await activeUseCase(activeParams).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => repo.activation(activeParams));
      verifyNoMoreInteractions(repo);
    });
  });
}
