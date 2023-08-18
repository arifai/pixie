import 'package:equatable/equatable.dart';

class CurrentUserEntity extends Equatable {
  const CurrentUserEntity({
    required this.fullName,
    required this.username,
    required this.email,
    required this.avatar,
    required this.isActive,
  });

  final String fullName;
  final String username;
  final String email;
  final String? avatar;
  final bool isActive;

  @override
  List<Object?> get props => [fullName, username, email, avatar, isActive];
}
