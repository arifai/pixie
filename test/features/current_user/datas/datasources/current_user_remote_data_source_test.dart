import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/networks/endpoints.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/cores/utils/di.dart' as di;
import 'package:pixie/features/current_user/datas/datasources/current_user_remote_data_source.dart';
import 'package:pixie/features/current_user/datas/models/current_user_response.dart';

import '../../../../fixtures/reader.dart';

void main() {
  late DioAdapter adapter;
  late CurrentUserRemoteDataSourceImp dataSourceImp;

  setUp(() {
    di.setup(true);
    adapter = DioAdapter(dio: di.di<Network>().dio);
    dataSourceImp = CurrentUserRemoteDataSourceImp(di.di<Network>());
  });

  group('CurrentUserRemoteDataSource', () {
    final Map<String, dynamic> success =
        jsonDecode(reader('current_user.json'));
    final Map<String, dynamic> notFound =
        jsonDecode(reader('current_user_not_found.json'));
    test('should return 200 when get current user successful', () async {
      adapter.onGet(Endpoints.currentUser, (server) {
        return server.reply(HttpStatus.ok, success);
      });

      (await dataSourceImp.get().run()).match(
        (l) => null,
        (r) => CurrentUserResponse.fromMap(success['result']),
      );
    });

    test('should return 404 when current user not found', () async {
      adapter.onGet(Endpoints.currentUser, (server) {
        return server.reply(HttpStatus.notFound, notFound);
      });

      (await dataSourceImp.get().run()).match(
        (l) => isA<NetworkFailure>()
            .having((v) => v.message, 'description', notFound['description']),
        (r) => null,
      );
    });
  });
}
