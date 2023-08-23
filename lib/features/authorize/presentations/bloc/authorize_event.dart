part of 'authorize_bloc.dart';

abstract class AuthorizeEvent extends Equatable {
  const AuthorizeEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

final class AuthorizeDoAuth extends AuthorizeEvent {
  const AuthorizeDoAuth(this.params);

  final AuthParams params;
}

final class AuthorizeDoUnAuth extends AuthorizeEvent {
  const AuthorizeDoUnAuth(this.token);

  final String token;
}

final class AuthorizeDoRegister extends AuthorizeEvent {
  const AuthorizeDoRegister(this.params);

  final RegisterParams params;
}

final class AuthorizeDoActivate extends AuthorizeEvent {
  const AuthorizeDoActivate(this.params);

  final ActivationParams params;
}
