import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/access_token/datas/models/access_token_response.dart';
import 'package:pixie/features/authorize/datas/repositories/authorize_repository_imp.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

import '../../../../fixtures/reader.dart';
import '../../../../mocks/authorize/mock_authorize_remote_data_source.dart';

void main() {
  late MockAuthorizeRemoteDataSource mockSource;
  late AuthorizeRepositoryImp repo;

  setUp(() {
    mockSource = MockAuthorizeRemoteDataSource();
    repo = AuthorizeRepositoryImp(mockSource);
  });

  group('AuthorizeRepositoryImp', () {
    const AuthParams params =
        AuthParams(username: 'username', password: 'password');
    final AccessTokenResponse response =
        AccessTokenResponse.fromMap(jsonDecode(reader('access_token.json')));

    test('should return AccessTokenResponse.fromMap() when user authorized',
        () async {
      when(() => mockSource.authorize(params))
          .thenAnswer((_) => TaskEither.of(response));

      final result = await repo.authorize(params).run();

      expect(result, equals(right(response)));
      verify(() => mockSource.authorize(params));
    });

    test('should return NetworkFailure when user authorize', () async {
      when(() => mockSource.authorize(params))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure('')));

      final result = await repo.authorize(params).run();

      expect(result, equals(left(const NetworkFailure(''))));
      verify(() => mockSource.authorize(params));
    });

    test('should return null when user unauthorized', () async {
      when(() => mockSource.unauthorize(any()))
          .thenAnswer((_) => TaskEither.of(null));

      await repo.unauthorize('').run();

      verify(() => mockSource.unauthorize(any()));
    });

    test('should return NetworkFailure when user unauthorize', () async {
      when(() => mockSource.unauthorize(any()))
          .thenAnswer((_) => TaskEither.left(const NetworkFailure('')));

      final result = await repo.unauthorize('').run();

      expect(result, equals(left(const NetworkFailure(''))));
      verify(() => mockSource.unauthorize(any()));
    });
  });
}
