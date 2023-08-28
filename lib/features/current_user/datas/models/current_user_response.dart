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
    if (data
        case {
          'fullName': String fullName,
          'username': String username,
          'email': String email,
          'avatar': String? avatar,
          'isActive': bool isActive,
        }) {
      return CurrentUserResponse(
        fullName: fullName,
        username: username,
        email: email,
        avatar: avatar,
        isActive: isActive,
      );
    } else {
      throw FormatException('Invalid json data: $data', StackTrace.current);
    }
  }
}
