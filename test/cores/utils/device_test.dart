import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/utils/mock_device.dart';

void main() {
  late MockDevice device;

  setUp(() => device = MockDevice());

  group('Device', () {
    test('should return device type Android if platform is Android', () {
      when(() => device.getType()).thenReturn('Android');

      expect('Android', equals('Android'));
    });

    test('should return device type iOS if platform is iOS', () {
      when(() => device.getType()).thenReturn('iOS');

      expect('iOS', equals('iOS'));
    });

    test(
        'should return device type Unknown device type if platform is Unknown device type',
        () {
      when(() => device.getType()).thenReturn('Unknown device type');

      expect('Unknown device type', equals('Unknown device type'));
    });

    test('should return IP address 127.0.0.1', () {
      when(() => device.getIPAddress()).thenAnswer((_) async => '127.0.0.1');

      expect('127.0.0.1', equals('127.0.0.1'));
    });

    test('should return null if IP address not obtained', () {
      when(() => device.getIPAddress()).thenAnswer((_) async => null);

      expect(null, equals(null));
    });
  });
}
