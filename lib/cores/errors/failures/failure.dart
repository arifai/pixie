import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message]);

  final dynamic message;

  @override // coverage:ignore-line
  List<Object> get props => [message]; // coverage:ignore-line
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class LocalFailure extends Failure {
  const LocalFailure([super.message]);
}
