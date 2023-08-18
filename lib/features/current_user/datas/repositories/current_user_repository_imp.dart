import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/features/current_user/datas/datasources/current_user_remote_data_source.dart';
import 'package:pixie/features/current_user/domains/entities/current_user_entity.dart';
import 'package:pixie/features/current_user/domains/repositories/current_user_repository.dart';

class CurrentUserRepositoryImp implements CurrentUserRepository {
  const CurrentUserRepositoryImp(this._dataSource);

  final CurrentUserRemoteDataSource _dataSource;

  @override
  TaskEither<Failure, CurrentUserEntity?> get() => _dataSource.get();
}
