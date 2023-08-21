part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class DoGetCurrentUser extends CurrentUserEvent {
  const DoGetCurrentUser();
}
