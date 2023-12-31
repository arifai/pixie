import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/environment/env.dart';
import 'package:pixie/cores/errors/failures/failure.dart';
import 'package:pixie/cores/networks/network.dart';
import 'package:pixie/cores/utils/isolate_parser.dart';

class NetworkImp implements Network {
  factory NetworkImp(bool test) => _singleton ??= NetworkImp._internal(test);

  final bool test;
  static NetworkImp? _singleton;
  late Dio _dio;

  NetworkImp._internal(this.test) {
    _dio = Dio(BaseOptions(
      baseUrl: !test ? Env.baseUrl : Env.baseUrlTest,
      sendTimeout: kDefaultDuration,
      receiveTimeout: kDefaultDuration,
      connectTimeout: kDefaultDuration,
      contentType: Headers.jsonContentType,
      followRedirects: false,
      validateStatus: (_) => true,
    ))
      // coverage:ignore-start
      ..interceptors.addAll([
        if (!test && kDebugMode)
          LogInterceptor(requestBody: true, responseBody: true)
      ]);
    // coverage:ignore-end
  }

  @override
  Dio get dio => _dio;

  @override
  ResultNetwork<T> get<T>({
    required String path,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? params,
  }) {
    return TaskEither.tryCatch(
      () async {
        final Response response = await _dio.get(path, queryParameters: params);
        final int statusCode = (response.statusCode ?? 0);
        final T? resp = await _handleResponse(statusCode, response, converter);

        return resp;
      },
      (error, _) {
        final DioException e = error as DioException;

        return NetworkFailure(
          e.response?.data['description'] as String? ?? e.message,
        );
      },
    );
  }

  @override
  ResultNetwork<T> post<T>({
    required String path,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> body,
  }) {
    return TaskEither.tryCatch(
      () async {
        final Response response = await _dio.post(path, data: body);
        final int statusCode = (response.statusCode ?? 0);
        final T? resp = await _handleResponse(statusCode, response, converter);

        return resp;
      },
      (error, _) {
        final DioException e = error as DioException;

        return NetworkFailure(
          e.response?.data['description'] as String? ?? e.message,
        );
      },
    );
  }

  Future<T?> _handleResponse<T>(
    int statusCode,
    Response response,
    ResponseConverter<T> converter,
  ) async {
    if (statusCode < HttpStatus.ok || statusCode > HttpStatus.created) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    } else {
      final IsolateParser<T> parser = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final T? result = await parser.parseInBackground().run();

      return result;
    }
  }
}
