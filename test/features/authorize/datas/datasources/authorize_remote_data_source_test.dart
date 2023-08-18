import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/networks/endpoints.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/cores/utils/di.dart' as di;
import 'package:pixie/features/access_token/datas/models/access_token_response.dart';
import 'package:pixie/features/authorize/datas/datasources/authorize_remote_data_source.dart';
import 'package:pixie/features/authorize/datas/models/registration_response.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

import '../../../../fixtures/reader.dart';

void main() {
  late DioAdapter adapter;
  late AuthorizeRemoteDataSourceImp dataSourceImp;

  setUp(() {
    di.setup(true);
    adapter = DioAdapter(dio: di.di<Network>().dio);
    dataSourceImp = AuthorizeRemoteDataSourceImp(di.di<Network>());
  });

  group('AuthorizeRemoteDataSource', () {
    final Faker faker = Faker();
    final Map<String, dynamic> success =
        jsonDecode(reader('access_token.json'));
    final Map<String, dynamic> badRequest =
        jsonDecode(reader('auth_bad_request.json'));
    final Map<String, dynamic> unauthorized =
        jsonDecode(reader('unauthorized.json'));
    final Map<String, dynamic> unAuthBadRequest =
        jsonDecode(reader('unauth_bad_request.json'));
    final Map<String, dynamic> registerSuccess =
        jsonDecode(reader('register_success.json'));
    final Map<String, dynamic> registerBadRequest =
        jsonDecode(reader('register_bad_request.json'));
    final Map<String, dynamic> activeSuccess =
        jsonDecode(reader('active_success.json'));
    final Map<String, dynamic> activeBadRequest =
        jsonDecode(reader('active_bad_request.json'));
    AuthParams params = AuthParams(
      username: faker.internet.userName(),
      password: faker.internet.password(),
    );
    RegisterParams registerParams = RegisterParams(
      fullName: faker.person.name(),
      username: faker.internet.userName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      device: faker.internet.userAgent(),
      ipAddress: faker.internet.ipv4Address(),
    );
    ActivationParams activeParams = ActivationParams(
      token: faker.jwt.expired(),
      activationCode: faker.randomGenerator.integer(6),
    );

    test('should return 200 when credential are correct', () async {
      adapter.onPost(Endpoints.authorize, (server) {
        return server.reply(HttpStatus.ok, success);
      }, data: params.toMap());

      (await dataSourceImp.authorize(params).run()).match(
        (l) => null,
        (r) => AccessTokenResponse.fromMap(success['result']),
      );
    });

    test('should return 400 when credential are incorrect', () async {
      adapter.onPost(Endpoints.authorize, (server) {
        return server.reply(HttpStatus.badRequest, badRequest);
      }, data: params.toMap());

      (await dataSourceImp.authorize(params).run()).match(
        (l) => isA<NetworkFailure>()
            .having((v) => v.message, 'description', badRequest['description']),
        (r) => null,
      );
    });

    test('should return 401 when user unauthorize successful', () async {
      adapter.onPost(Endpoints.unauthorize, (server) {
        return server.reply(HttpStatus.unauthorized, unauthorized);
      }, data: {'accessToken': faker.jwt.expired()});

      (await dataSourceImp.unauthorize(faker.jwt.expired()).run()).match(
        (l) => null,
        (r) => null,
      );
    });

    test('should return 400 when user unauthorize unsuccessful', () async {
      adapter.onPost(Endpoints.unauthorize, (server) {
        return server.reply(HttpStatus.badRequest, unAuthBadRequest);
      }, data: {'accessToken': null});

      (await dataSourceImp.unauthorize(null).run()).match(
        (l) => isA<NetworkFailure>().having(
            (v) => v.message, 'description', unAuthBadRequest['description']),
        (r) => null,
      );
    });

    test('should return 201 when user registration successful', () async {
      adapter.onPost(Endpoints.registration, (server) {
        return server.reply(HttpStatus.created, registerSuccess);
      }, data: registerParams.toMap());

      (await dataSourceImp.registration(registerParams).run()).match(
        (l) => null,
        (r) => RegistrationResponse.fromMap(registerSuccess),
      );
    });

    test('should return 400 when username is already registered', () async {
      adapter.onPost(Endpoints.registration, (server) {
        return server.reply(HttpStatus.badRequest, registerBadRequest);
      }, data: registerParams.toMap());

      (await dataSourceImp.registration(registerParams).run()).match(
        (l) => isA<NetworkFailure>().having(
            (v) => v.message, 'description', registerBadRequest['description']),
        (r) => null,
      );
    });

    test('should return 200 when user activation successful', () async {
      adapter.onPost(Endpoints.activation, (server) {
        return server.reply(HttpStatus.ok, activeSuccess);
      }, data: activeParams.toMap());

      (await dataSourceImp.activation(activeParams).run()).match(
        (l) => null,
        (r) => RegistrationResponse.fromMap(activeSuccess),
      );
    });

    test('should return 400 when activation code is expired', () async {
      adapter.onPost(Endpoints.activation, (server) {
        return server.reply(HttpStatus.badRequest, activeBadRequest);
      }, data: activeParams.toMap());

      (await dataSourceImp.activation(activeParams).run()).match(
        (l) => isA<NetworkFailure>().having(
            (v) => v.message, 'description', activeBadRequest['description']),
        (r) => null,
      );
    });
  });
}
