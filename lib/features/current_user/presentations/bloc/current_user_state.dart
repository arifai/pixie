part of 'current_user_bloc.dart';

enum CurrentUserStatus { initial, loading, success, failed }

class CurrentUserState extends Equatable {
  const CurrentUserState({
    this.status = CurrentUserStatus.initial,
    this.message,
    this.data,
  });

  final CurrentUserStatus status;
  final String? message;
  final CurrentUserEntity? data;

  CurrentUserState copy({
    CurrentUserStatus? status,
    String? message,
    CurrentUserEntity? data,
  }) {
    return CurrentUserState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
