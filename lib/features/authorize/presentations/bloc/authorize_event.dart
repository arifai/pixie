part of 'authorize_bloc.dart';

sealed class AuthorizeEvent extends Equatable {
  const AuthorizeEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

final class AuthorizeDoAuth extends AuthorizeEvent {
  const AuthorizeDoAuth(this.params);

  final AuthParams params;

  @override
  List<Object?> get props => [params];
}

final class AuthorizeDoUnAuth extends AuthorizeEvent {
  const AuthorizeDoUnAuth(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

final class AuthorizeDoRegister extends AuthorizeEvent {
  const AuthorizeDoRegister(this.params);

  final RegisterParams params;

  @override
  List<Object?> get props => [params];
}

final class AuthorizeDoActivate extends AuthorizeEvent {
  const AuthorizeDoActivate(this.params);

  final ActivationParams params;

  @override
  List<Object?> get props => [params];
}
