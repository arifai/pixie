import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';
import 'package:pixie/features/current_user/presentations/bloc/current_user_bloc.dart';

import '../../../../mocks/current_user/mock_get_current_user_usecase.dart';

void main() {
  late MockGetCurrentUserUseCase currentUseCase;
  late CurrentUserBloc bloc;

  setUp(() {
    currentUseCase = MockGetCurrentUserUseCase();
    bloc = CurrentUserBloc(currentUseCase);
  });

  group('CurrentUserBloc', () {
    final Faker faker = Faker();
    final CurrentUserEntity data = CurrentUserEntity(
      fullName: faker.person.name(),
      username: faker.internet.userName(),
      email: faker.internet.email(),
      avatar: faker.internet.httpsUrl(),
      isActive: true,
    );

    test('initial state should be CurrentUserStatus.initial', () {
      expect(bloc.state.status, equals(CurrentUserStatus.initial));
    });

    blocTest(
      'should emit [CurrentUserStatus.initial, CurrentUserStatus.success] when get user is successful',
      build: () {
        when(() => currentUseCase(const NoParams()))
            .thenAnswer((_) => TaskEither.of(data));

        return bloc;
      },
      act: (bloc) => bloc.add(const CurrentUserDoGetUser()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const CurrentUserState(status: CurrentUserStatus.loading),
        CurrentUserState(status: CurrentUserStatus.success, data: data),
      ],
      verify: (_) => verify(() => currentUseCase(const NoParams())),
    );

    blocTest(
      'should emit [CurrentUserStatus.initial, CurrentUserStatus.failed] when get user is unsuccessful',
      build: () {
        when(() => currentUseCase(const NoParams()))
            .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

        return bloc;
      },
      act: (bloc) => bloc.add(const CurrentUserDoGetUser()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const CurrentUserState(status: CurrentUserStatus.loading),
        const CurrentUserState(status: CurrentUserStatus.failed),
      ],
      verify: (_) => verify(() => currentUseCase(const NoParams())),
    );
  });
}
