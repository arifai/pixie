import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';

/// Convert `json` response from server with [IsolateParser].
///
/// [T] represents the type of the success value.
typedef ResponseConverter<T> = T Function(dynamic response);

/// Shortcut for `TaskEither<Failure, T?>`.
///
/// [T] represents the type of the success value
typedef ResultNetwork<T> = TaskEither<Failure, T?>;

/// Default duration for `sendTimeout`, `receiveTimeout`, `connectTimeout` for [Dio].
/// Default value is `seconds: 10`
Duration get kDefaultDuration => const Duration(seconds: 10);

/// A interface class http request for communicated with server
abstract class Network {
  /// Get [Dio] instance
  Dio get dio;

  /// Handle http POST method request.
  ResultNetwork<T> post<T>({
    required String path,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> body,
  });

  /// Handle http GET method request.
  ResultNetwork<T> get<T>({
    required String path,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? params,
  });
}
