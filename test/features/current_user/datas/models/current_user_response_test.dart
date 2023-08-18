import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pixie/features/current_user/datas/models/current_user_response.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';

import '../../../../fixtures/reader.dart';

void main() {
  group('CurrentUserResponse', () {
    final Map<String, dynamic> data = jsonDecode(reader('current_user.json'));
    final String fullName = data['result']['fullName'];
    final String username = data['result']['username'];
    final String email = data['result']['email'];
    final String avatar = data['result']['avatar'];
    final bool isActive = data['result']['isActive'];
    final CurrentUserResponse response = CurrentUserResponse(
      fullName: fullName,
      username: username,
      email: email,
      avatar: avatar,
      isActive: isActive,
    );

    test('should be subclass of CurrentUserEntity', () {
      expect(
        response,
        isA<CurrentUserEntity>()
            .having((v) => v.fullName, 'fullName', fullName)
            .having((v) => v.username, 'username', username)
            .having((v) => v.email, 'email', email)
            .having((v) => v.avatar, 'avatar', avatar)
            .having((v) => v.isActive, 'isActive', isActive),
      );
    });

    test('should return datas from response', () {
      final CurrentUserResponse result =
          CurrentUserResponse.fromMap(data['result']);

      expect(result, response);
    });
  });
}
