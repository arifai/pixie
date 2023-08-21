part of 'authorize_bloc.dart';

abstract class AuthorizeEvent extends Equatable {
  const AuthorizeEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class DoAuthorize extends AuthorizeEvent {
  const DoAuthorize(this.params);

  final AuthParams params;
}

class DoUnAuthorize extends AuthorizeEvent {
  const DoUnAuthorize(this.token);

  final String token;
}

class DoRegister extends AuthorizeEvent {
  const DoRegister(this.params);

  final RegisterParams params;
}

class DoActivate extends AuthorizeEvent {
  const DoActivate(this.params);

  final ActivationParams params;
}
