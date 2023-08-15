import 'dart:isolate';

import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/networks/network.dart';

/// {@template isolate_parser}
/// Decode `json` with isolate memory. Which mean [IsolateParser] can handle
/// large `json` payload.
/// {@endtemplate}
class IsolateParser<T> {
  /// {@macro isolate_parser}
  IsolateParser(this.json, this.converter);

  final Map<String, dynamic> json;
  final ResponseConverter<T> converter;

  /// Decode `json` in background proccess.
  Task<T> parseInBackground() {
    return Task<T>(() async {
      final ReceivePort port = ReceivePort('background_json_parser');
      await Isolate.spawn(_parseListOfJson, port.sendPort);

      final dynamic result = await port.first;

      return result as T;
    });
  }

  Future<void> _parseListOfJson(SendPort sendPort) {
    return Task<void>(() {
      final dynamic result = converter(json);
      Isolate.exit(sendPort, result);
    }).run();
  }
}
