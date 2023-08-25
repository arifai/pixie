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

  // coverage:ignore-start
  @override
  List<Object?> get props => [params];
  // coverage:ignore-end
}

final class AuthorizeDoUnAuth extends AuthorizeEvent {
  const AuthorizeDoUnAuth(this.token);

  final String token;

  // coverage:ignore-start
  @override
  List<Object?> get props => [token];
  // coverage:ignore-end
}

final class AuthorizeDoRegister extends AuthorizeEvent {
  const AuthorizeDoRegister(this.params);

  final RegisterParams params;

  // coverage:ignore-start
  @override
  List<Object?> get props => [params];
  // coverage:ignore-end
}

final class AuthorizeDoActivate extends AuthorizeEvent {
  const AuthorizeDoActivate(this.params);

  final ActivationParams params;

  // coverage:ignore-start
  @override
  List<Object?> get props => [params];
  // coverage:ignore-end
}
