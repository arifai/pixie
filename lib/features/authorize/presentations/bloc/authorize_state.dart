part of 'authorize_bloc.dart';

enum AuthorizeStatus { initial, loading, success, failed }

class AuthorizeState extends Equatable {
  const AuthorizeState({
    this.status = AuthorizeStatus.initial,
    this.message,
    this.accessToken,
    this.registration,
  });

  final AuthorizeStatus status;
  final String? message;
  final AccessTokenEntity? accessToken;
  final RegistrationEntity? registration;

  AuthorizeState copy({
    AuthorizeStatus? status,
    String? message,
    AccessTokenEntity? accessToken,
    RegistrationEntity? registration,
  }) {
    return AuthorizeState(
      status: status ?? this.status,
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      registration: registration ?? this.registration,
    );
  }

  @override
  List<Object?> get props => [status, message, accessToken, registration];
}
