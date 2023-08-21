import 'package:mocktail/mocktail.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';

class MockAuthorizeUseCase extends Mock implements AuthorizeUseCase {}

class MockUnAuthorizeUseCase extends Mock implements UnAuthorizeUseCase {}

class MockRegistrationUseCase extends Mock implements RegistrationUseCase {}

class MockActivationUseCase extends Mock implements ActivationUseCase {}
