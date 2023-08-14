import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:pixie/features/access_token/domains/usecases/access_token_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccessTokenLocalDataSource {
  Task<bool> save(AccessTokenParams token);
  Task<bool> remove();
  String? get();
}

class AccessTokenLocalDataSourceImp implements AccessTokenLocalDataSource {
  const AccessTokenLocalDataSourceImp(this._prefs);

  final SharedPreferences _prefs;
  final String tokenKey = 'CACHED_ACCESS_TOKEN';

  @override
  Task<bool> save(AccessTokenParams token) {
    return Task(() async =>
        await _prefs.setString(tokenKey, jsonEncode(token.toMap())));
  }

  @override
  Task<bool> remove() {
    return Task(() async => await _prefs.remove(tokenKey));
  }

  @override
  String? get() => _prefs.getString(tokenKey);
}
