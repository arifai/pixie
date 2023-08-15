import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/features/access_token/datas/datasources/access_token_local_data_source.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';

import '../../../../mocks/mock_shared_preferences.dart';

void main() {
  late MockSharedPreferences shared;
  late AccessTokenLocalDataSourceImp dataSource;

  setUp(() {
    shared = MockSharedPreferences();
    dataSource = AccessTokenLocalDataSourceImp(shared);
  });

  group('AccessTokenLocalDataSource', () {
    const String tokenKey = 'CACHED_ACCESS_TOKEN';
    final Faker faker = Faker();
    final String jwt = faker.jwt.expired();
    final AccessTokenParams params = AccessTokenParams(
      accessToken: jwt,
      refreshToken: jwt,
    );

    test('should call SharedPreferences to cache the data', () async {
      when(() => shared.setString(any(), any())).thenAnswer((_) async => true);

      await dataSource.save(params).run();

      verify(() => shared.setString(tokenKey, jsonEncode(params.toMap())));
    });

    test('should return false from SharedPreferences', () async {
      when(() => shared.setString(any(), any())).thenAnswer((_) async => false);

      await dataSource.save(params).run();

      verify(() => shared.setString(tokenKey, jsonEncode(params.toMap())));
    });

    test('should return true when remove CACHED_ACCESS_TOKEN', () async {
      when(() => shared.remove(tokenKey)).thenAnswer((_) async => true);

      await dataSource.remove().run();

      verify(() => shared.remove(tokenKey));
    });

    test('should return false when remove CACHED_ACCESS_TOKEN', () async {
      when(() => shared.remove(tokenKey)).thenAnswer((_) async => false);

      await dataSource.remove().run();

      verify(() => shared.remove(tokenKey));
    });

    test('should return the data from SharedPreferences', () {
      when(() => shared.getString(any()))
          .thenAnswer((_) => jsonEncode(params.toMap()));

      final result = dataSource.get();

      expect(result, equals(jsonEncode(params.toMap())));
      verify(() => shared.getString(tokenKey));
    });

    test('should return null from SharedPreferences', () {
      when(() => shared.getString(any())).thenAnswer((_) => null);

      final result = dataSource.get();

      expect(result, equals(null));
      verify(() => shared.getString(tokenKey));
    });
  });
}
