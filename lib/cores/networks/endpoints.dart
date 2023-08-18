// coverage:ignore-file

/// Required set of endpoints.
class Endpoints {
  const Endpoints._();

  static const String authorize = '/user/v1/authorize';
  static const String unauthorize = '/user/v1/unauthorize';
  static const String registration = '/user/v1/registration';
  static const String activation = '/user/v1/activation';
  static const String currentUser = '/user/v1/me';
}
