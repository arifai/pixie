part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

final class CurrentUserDoGetUser extends CurrentUserEvent {
  const CurrentUserDoGetUser();
}
