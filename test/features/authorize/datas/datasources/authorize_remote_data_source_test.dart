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
    const AuthParams params = AuthParams(username: 'abc', password: 'abc');

    test('should return 200 when credential are correct', () async {
      adapter.onPost(Endpoints.authorize, (server) {
        return server.reply(HttpStatus.ok, success);
      }, data: params.toMap());

      (await dataSourceImp.authorize(params).run()).match(
        (l) => null,
        (r) => AccessTokenResponse.fromMap(success),
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

    test('should return 401 when user unauthorized', () async {
      adapter.onPost(Endpoints.unauthorize, (server) {
        return server.reply(HttpStatus.unauthorized, unauthorized);
      }, data: {'accessToken': faker.jwt.expired()});

      (await dataSourceImp.authorize(params).run()).match(
        (l) => null,
        (r) => null,
      );
    });

    test('should return 400 when user unauthorize', () async {
      adapter.onPost(Endpoints.unauthorize, (server) {
        return server.reply(HttpStatus.badRequest, unAuthBadRequest);
      }, data: {'accessToken': null});

      (await dataSourceImp.authorize(params).run()).match(
        (l) => isA<NetworkFailure>().having(
            (v) => v.message, 'description', unAuthBadRequest['description']),
        (r) => null,
      );
    });
  });
}
