import 'package:equatable/equatable.dart';

class RegistrationEntity extends Equatable {
  const RegistrationEntity(this.token);

  final String? token;

  @override
  List<Object?> get props => [token];
}
