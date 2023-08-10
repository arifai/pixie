import 'package:fpdart/fpdart.dart';

abstract class AccessTokenLocalDataSource {
  Task<bool> save(String token);
  Task<bool> remove();
  String? get();
}
