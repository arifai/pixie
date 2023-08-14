import 'package:fpdart/fpdart.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';

abstract class AccessTokenLocalDataSource {
  Task<bool> save(AccessTokenParams token);
  Task<bool> remove();
  String? get();
}

class AccessTokenLocalDataSourceImp implements AccessTokenLocalDataSource {
  @override
  Task<bool> save(AccessTokenParams token) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Task<bool> remove() {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  String? get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}
