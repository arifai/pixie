import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';

class CurrentUserResponse extends CurrentUserEntity {
  const CurrentUserResponse({
    required super.fullName,
    required super.username,
    required super.email,
    required super.avatar,
    required super.isActive,
  });

  factory CurrentUserResponse.fromMap(Map<String, dynamic> data) {
    return CurrentUserResponse(
      fullName: data['fullName'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      avatar: data['avatar'] as String?,
      isActive: data['isActive'] as bool,
    );
  }
}
