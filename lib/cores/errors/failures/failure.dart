import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message]);

  final dynamic message;

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class LocalFailure extends Failure {
  const LocalFailure([super.message]);
}
