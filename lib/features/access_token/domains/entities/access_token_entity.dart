import 'package:equatable/equatable.dart';

class AccessTokenEntity extends Equatable {
  const AccessTokenEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
