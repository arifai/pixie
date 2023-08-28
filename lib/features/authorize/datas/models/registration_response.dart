import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';

class RegistrationResponse extends RegistrationEntity {
  const RegistrationResponse(super.token);

  factory RegistrationResponse.fromMap(Map<String, dynamic> data) {
    if (data case {'result': String? token}) {
      return RegistrationResponse(token);
    } else {
      throw FormatException('Invalid json data: $data', StackTrace.current);
    }
  }
}
