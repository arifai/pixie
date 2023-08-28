import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message]);

  final dynamic message;

  // coverage:ignore-start
  @override
  List<Object?> get props => [message];
  // coverage:ignore-end
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class LocalFailure extends Failure {
  const LocalFailure([super.message]);
}
