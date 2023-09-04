import 'package:bloc_test/bloc_test.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';

class MockAuthorizeBloc extends MockBloc<AuthorizeEvent, AuthorizeState>
    implements AuthorizeBloc {}
