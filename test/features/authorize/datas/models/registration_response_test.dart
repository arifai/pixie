import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pixie/features/authorize/datas/models/registration_response.dart';
import 'package:pixie/features/authorize/domains/entities/registration_entity.dart';

import '../../../../fixtures/reader.dart';

void main() {
  group('RegistrationResponse', () {
    final Map<String, dynamic> data =
        jsonDecode(reader('register_success.json'));
    final RegistrationResponse response = RegistrationResponse(data['result']);

    test('should be subclass of RegistrationEntity', () {
      expect(response,
          isA<RegistrationEntity>().having((v) => v.token, '', data['result']));
    });

    test('should return register token from response', () {
      final RegistrationResponse result = RegistrationResponse.fromMap(data);

      expect(result, response);
    });

    test('should throw FormatException if json data is invalid', () {
      final Map<String, dynamic> invalid = {};

      expect(
          () => RegistrationResponse.fromMap(invalid), throwsFormatException);
    });
  });
}
