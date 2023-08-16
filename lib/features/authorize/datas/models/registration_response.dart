import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';

class RegistrationResponse extends RegistrationEntity {
  const RegistrationResponse(super.token);

  factory RegistrationResponse.fromMap(Map<String, dynamic> data) {
    return RegistrationResponse(data['result'] as String?);
  }
}
