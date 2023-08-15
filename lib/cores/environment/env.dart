import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true, requireEnvFile: true)
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'BASE_URL_TEST')
  static final String baseUrlTest = _Env.baseUrlTest;
}
