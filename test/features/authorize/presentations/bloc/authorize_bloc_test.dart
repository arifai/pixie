import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';

import '../../../../mocks/authorize/mock_authorize_usecase.dart';

void main() {
  late MockAuthorizeUseCase authUseCase;
  late MockUnAuthorizeUseCase unAuthUseCase;
  late MockRegistrationUseCase registerUseCase;
  late MockActivationUseCase activateUseCase;
  late AuthorizeBloc bloc;

  setUp(() {
    authUseCase = MockAuthorizeUseCase();
    unAuthUseCase = MockUnAuthorizeUseCase();
    registerUseCase = MockRegistrationUseCase();
    activateUseCase = MockActivationUseCase();
    bloc = AuthorizeBloc(
      authUseCase: authUseCase,
      unAuthUseCase: unAuthUseCase,
      registerUseCase: registerUseCase,
      activateUseCase: activateUseCase,
    );
  });

  group('AuthorizeBloc', () {
    final Faker faker = Faker();
    final String jwt = faker.jwt.expired();
    final AuthParams authParams = AuthParams(
      username: faker.internet.userName(),
      password: faker.internet.password(),
    );
    final AccessTokenEntity accessTokenEntity = AccessTokenEntity(
      accessToken: jwt,
      refreshToken: jwt,
    );
    final RegistrationEntity registrationEntity = RegistrationEntity(jwt);
    final RegisterParams registerParams = RegisterParams(
      fullName: faker.person.name(),
      username: faker.internet.userName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      device: faker.randomGenerator.string(6),
      ipAddress: faker.internet.ipv4Address(),
    );
    final ActivationParams activationParams = ActivationParams(
      token: jwt,
      activationCode: faker.randomGenerator.integer(6),
    );

    group('Authorization', () {
      test('initial state should be AthorizeStatus.initial', () {
        expect(bloc.state.status, equals(AuthorizeStatus.initial));
      });

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.success] when user authorize is successful',
        build: () {
          when(() => authUseCase(authParams))
              .thenAnswer((_) => TaskEither.of(accessTokenEntity));

          return bloc;
        },
        act: (bloc) => bloc.add(DoAuthorize(authParams)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          AuthorizeState(
            status: AuthorizeStatus.success,
            accessToken: accessTokenEntity,
          ),
        ],
        verify: (_) => verify(() => authUseCase(authParams)),
      );

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.failed] when user authorize is unsuccessful',
        build: () {
          when(() => authUseCase(authParams))
              .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

          return bloc;
        },
        act: (bloc) => bloc.add(DoAuthorize(authParams)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          const AuthorizeState(status: AuthorizeStatus.failed),
        ],
        verify: (_) => verify(() => authUseCase(authParams)),
      );
    });

    group('UnAuthorization', () {
      test('initial state should be AthorizeStatus.initial', () {
        expect(bloc.state.status, equals(AuthorizeStatus.initial));
      });

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.success] when user unauthorize is successful',
        build: () {
          when(() => unAuthUseCase(jwt))
              .thenAnswer((_) => TaskEither.of(registrationEntity));

          return bloc;
        },
        act: (bloc) => bloc.add(DoUnAuthorize(jwt)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          AuthorizeState(
            status: AuthorizeStatus.success,
            registration: registrationEntity,
          ),
        ],
        verify: (_) => verify(() => unAuthUseCase(jwt)),
      );

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.failed] when user unauthorize is unsuccessful',
        build: () {
          when(() => unAuthUseCase(jwt))
              .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

          return bloc;
        },
        act: (bloc) => bloc.add(DoUnAuthorize(jwt)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          const AuthorizeState(status: AuthorizeStatus.failed),
        ],
        verify: (_) => verify(() => unAuthUseCase(jwt)),
      );
    });

    group('Registration', () {
      test('initial state should be AthorizeStatus.initial', () {
        expect(bloc.state.status, equals(AuthorizeStatus.initial));
      });

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.success] when user registration is successful',
        build: () {
          when(() => registerUseCase(registerParams))
              .thenAnswer((_) => TaskEither.of(registrationEntity));

          return bloc;
        },
        act: (bloc) => bloc.add(DoRegister(registerParams)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          AuthorizeState(
            status: AuthorizeStatus.success,
            registration: registrationEntity,
          ),
        ],
        verify: (_) => verify(() => registerUseCase(registerParams)),
      );

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.failed] when user registration is unsuccessful',
        build: () {
          when(() => registerUseCase(registerParams))
              .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

          return bloc;
        },
        act: (bloc) => bloc.add(DoRegister(registerParams)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          const AuthorizeState(status: AuthorizeStatus.failed),
        ],
        verify: (_) => verify(() => registerUseCase(registerParams)),
      );
    });

    group('Activation', () {
      test('initial state should be AthorizeStatus.initial', () {
        expect(bloc.state.status, equals(AuthorizeStatus.initial));
      });

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.success] when user activation is successful',
        build: () {
          when(() => activateUseCase(activationParams))
              .thenAnswer((_) => TaskEither.of(registrationEntity));

          return bloc;
        },
        act: (bloc) => bloc.add(DoActivate(activationParams)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          AuthorizeState(
            status: AuthorizeStatus.success,
            registration: registrationEntity,
          ),
        ],
        verify: (_) => verify(() => activateUseCase(activationParams)),
      );

      blocTest<AuthorizeBloc, AuthorizeState>(
        'should emit [AuthorizeStatus.loading, AuthorizeStatus.failed] when user registration is unsuccessful',
        build: () {
          when(() => activateUseCase(activationParams))
              .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

          return bloc;
        },
        act: (bloc) => bloc.add(DoActivate(activationParams)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          const AuthorizeState(status: AuthorizeStatus.loading),
          const AuthorizeState(status: AuthorizeStatus.failed),
        ],
        verify: (_) => verify(() => activateUseCase(activationParams)),
      );
    });
  });
}
