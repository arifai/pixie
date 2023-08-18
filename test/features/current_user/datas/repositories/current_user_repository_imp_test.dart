import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/current_user/datas/models/current_user_response.dart';
import 'package:pixie/features/current_user/datas/repositories/current_user_repository_imp.dart';

import '../../../../fixtures/reader.dart';
import '../../../../mocks/current_user/mock_current_user_remote_data_source.dart';

void main() {
  late MockCurrentUserRemoteDataSource mockSource;
  late CurrentUserRepositoryImp repo;

  setUp(() {
    mockSource = MockCurrentUserRemoteDataSource();
    repo = CurrentUserRepositoryImp(mockSource);
  });
  group('CurrentUserRepositoryImp', () {
    final Map<String, dynamic> data = jsonDecode(reader('current_user.json'));
    final CurrentUserResponse response =
        CurrentUserResponse.fromMap(data['result']);
    test(
        'should return CurrentUserResponse.fromMap() when get current user successful',
        () async {
      when(() => mockSource.get()).thenAnswer((_) => TaskEither.of(response));

      final result = await repo.get().run();

      expect(result, equals(right(response)));
      verify(() => mockSource.get());
    });

    test('should return NetworkFailure when failure to get current user',
        () async {
      when(() => mockSource.get())
          .thenAnswer((_) => TaskEither.left(const NetworkFailure()));

      final result = await repo.get().run();

      expect(result, equals(left(const NetworkFailure())));
      verify(() => mockSource.get());
    });
  });
}
