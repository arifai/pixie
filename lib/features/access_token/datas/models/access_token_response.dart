import 'package:pixie/features/access_token/domains/entities/access_token_entity.dart';

class AccessTokenResponse extends AccessTokenEntity {
  const AccessTokenResponse({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AccessTokenResponse.fromMap(Map<String, dynamic> data) {
    return AccessTokenResponse(
      accessToken: data['result']['accessToken'],
      refreshToken: data['result']['refreshToken'],
    );
  }
}
