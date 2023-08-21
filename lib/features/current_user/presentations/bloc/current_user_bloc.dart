import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixie/cores/usecase/usecase.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';
import 'package:pixie/features/current_user/domains/usecases/current_user_usecase.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final GetCurrentUserUseCase getUseCase;

  CurrentUserBloc(this.getUseCase) : super(const CurrentUserState()) {
    on<DoGetCurrentUser>((event, emit) async {
      emit(state.copy(status: CurrentUserStatus.loading));

      (await getUseCase(const NoParams()).run()).match(
        (l) {
          emit(
            state.copy(status: CurrentUserStatus.failed, message: l.message),
          );
        },
        (r) => emit(state.copy(status: CurrentUserStatus.success, data: r)),
      );
    });
  }
}
