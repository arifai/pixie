import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

part 'authorize_event.dart';
part 'authorize_state.dart';

class AuthorizeBloc extends Bloc<AuthorizeEvent, AuthorizeState> {
  final AuthorizeUseCase authUseCase;
  final UnAuthorizeUseCase unAuthUseCase;
  final RegistrationUseCase registerUseCase;
  final ActivationUseCase activateUseCase;

  AuthorizeBloc({
    required this.authUseCase,
    required this.unAuthUseCase,
    required this.registerUseCase,
    required this.activateUseCase,
  }) : super(const AuthorizeState()) {
    on<AuthorizeDoAuth>((event, emit) async {
      emit(state.copy(status: AuthorizeStatus.loading));

      (await authUseCase(event.params).run()).match(
        (l) {
          emit(state.copy(status: AuthorizeStatus.failed, message: l.message));
        },
        (r) {
          emit(state.copy(status: AuthorizeStatus.success, accessToken: r));
        },
      );
    });

    on<AuthorizeDoUnAuth>((event, emit) async {
      emit(state.copy(status: AuthorizeStatus.loading));

      (await unAuthUseCase(event.token).run()).match(
        (l) {
          emit(state.copy(status: AuthorizeStatus.failed, message: l.message));
        },
        (r) {
          emit(state.copy(status: AuthorizeStatus.success, registration: r));
        },
      );
    });

    on<AuthorizeDoRegister>((event, emit) async {
      emit(state.copy(status: AuthorizeStatus.loading));

      (await registerUseCase(event.params).run()).match(
        (l) {
          emit(state.copy(status: AuthorizeStatus.failed, message: l.message));
        },
        (r) {
          emit(state.copy(status: AuthorizeStatus.success, registration: r));
        },
      );
    });

    on<AuthorizeDoActivate>((event, emit) async {
      emit(state.copy(status: AuthorizeStatus.loading));

      (await activateUseCase(event.params).run()).match(
        (l) {
          emit(state.copy(status: AuthorizeStatus.failed, message: l.message));
        },
        (r) {
          emit(state.copy(status: AuthorizeStatus.success, registration: r));
        },
      );
    });
  }
}
