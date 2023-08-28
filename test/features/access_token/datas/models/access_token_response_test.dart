import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pixie/features/access_token/datas/models/access_token_response.dart';
import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';

import '../../../../fixtures/reader.dart';

void main() {
  group('AccessTokenResponse', () {
    final Map<String, dynamic> data = jsonDecode(reader('access_token.json'));
    final String accessToken = data['result']['accessToken'];
    final String refreshToken = data['result']['refreshToken'];

    final AccessTokenResponse response = AccessTokenResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    test('should be subclass of AccessTokenEntity', () {
      expect(
        response,
        isA<AccessTokenEntity>()
            .having((v) => v.accessToken, 'accessToken', accessToken)
            .having((v) => v.refreshToken, 'refreshToken', refreshToken),
      );
    });

    test('should return datas from response', () {
      final AccessTokenResponse result =
          AccessTokenResponse.fromMap(data['result']);

      expect(result, equals(response));
    });

    test('should throw FormatException if json data is invalid', () {
      final Map<String, dynamic> invalid = {};

      expect(() => AccessTokenResponse.fromMap(invalid), throwsFormatException);
    });
  });
}
