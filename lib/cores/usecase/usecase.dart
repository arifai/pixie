import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixie/cores/errors/failures/failure.dart';

/// {@template usecase}
/// An interface for creating new usecases.
///
/// [T] represents what type of data to return.
///
/// [P] what type of parameter is used.
///
/// ```dart
/// class UserUseCase extends UseCase<UserEntity, UserParams> {
///   const UserUseCase();
///
///   @override
///   TaskEither<Failure, UserEntity?> call(UserParams params) {}
/// }
/// ```
/// {@endtemplate}
abstract class UseCase<T, P extends dynamic> {
  /// {@macro usecase}
  const UseCase();

  /// To allow an instance of class to be called like a function,
  /// implement the call() method.
  ///
  /// See: https://dart.dev/language/callable-objects
  TaskEither<Failure, T?> call(P params);
}

// coverage:ignore-start
/// {@template no_params}
/// A class to represent does not require parameters in the usecase.
/// {@endtemplate}
@Deprecated(
    '''This class is no longer needed. Use void instead of [NoParams] class. 
This class will be removed in the next version.''')
class NoParams extends Equatable {
  /// {@macro no_params}
  const NoParams();

  @override
  List<Object?> get props => [];
}
// coverage:ignore-end