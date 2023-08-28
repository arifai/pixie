import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';

class AccessTokenResponse extends AccessTokenEntity {
  const AccessTokenResponse({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AccessTokenResponse.fromMap(Map<String, dynamic> data) {
    if (data
        case {
          'accessToken': String? accessToken,
          'refreshToken': String? refreshToken
        }) {
      return AccessTokenResponse(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    } else {
      throw FormatException('Invalid json data: $data', StackTrace.current);
    }
  }
}
