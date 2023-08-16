import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/datas/models/access_token_response.dart';
import 'package:pixie/features/authorize/datas/models/registration_response.dart';
import 'package:pixie/features/authorize/datas/repositories/authorize_repository_imp.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

import '../../../../fixtures/reader.dart';
import '../../../../mocks/authorize/mock_authorize_remote_data_source.dart';

void main() {
  late MockAuthorizeRemoteDataSource mockSource;
  late AuthorizeRepositoryImp repo;

  setUp(() {
    mockSource = MockAuthorizeRemoteDataSource();
    repo = AuthorizeRepositoryImp(mockSource);
  });

  group('AuthorizeRepositoryImp', () {
    final Faker faker = Faker();
    final AccessTokenResponse response =
        AccessTokenResponse.fromMap(jsonDecode(reader('access_token.json')));
    final RegistrationResponse registerSuccess = RegistrationResponse.fromMap(
        jsonDecode(reader('register_success.json')));
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

    test('should return AccessTokenResponse.fromMap() when user authorized',
        () async {
      when(() => mockSource.authorize(params))
          .thenAnswer((_) => TaskEither.of(response));

      final result = await repo.authorize(params).run();

      expect(result, equals(right(response)));
      verify(() => mockSource.authorize(params));
    });

    test('should return NetworkFailure when user authorize', () async {
      when(() => mockSource.authorize(params))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await repo.authorize(params).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => mockSource.authorize(params));
    });

    test('should return null when user unauthorized', () async {
      when(() => mockSource.unauthorize(any()))
          .thenAnswer((_) => TaskEither.of(null));

      await repo.unauthorize('').run();

      verify(() => mockSource.unauthorize(any()));
    });

    test('should return NetworkFailure when user unauthorize', () async {
      when(() => mockSource.unauthorize(any()))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await repo.unauthorize('').run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => mockSource.unauthorize(any()));
    });

    test('should return token when user registration successful', () async {
      when(() => mockSource.registration(registerParams))
          .thenAnswer((_) => TaskEither.of(registerSuccess));

      final result = await repo.registration(registerParams).run();

      expect(result, equals(right(registerSuccess)));
      verify(() => mockSource.registration(registerParams));
    });

    test('should return NetworkFailure when user registration unsuccessful',
        () async {
      when(() => mockSource.registration(registerParams))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await repo.registration(registerParams).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => mockSource.registration(registerParams));
    });

    test('should return token when user activation successful', () async {
      when(() => mockSource.activation(activeParams))
          .thenAnswer((_) => TaskEither.of(null));

      final result = await repo.activation(activeParams).run();

      expect(result, equals(right(null)));
      verify(() => mockSource.activation(activeParams));
    });

    test('should return NetworkFailure when user activation unsuccessful',
        () async {
      when(() => mockSource.activation(activeParams))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await repo.activation(activeParams).run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => mockSource.activation(activeParams));
    });
  });
}
