import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixie/cores/constants/app_keys.dart';
import 'package:pixie/cores/utils/di.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';
import 'package:pixie/features/authorize/presentations/pages/authorize_page.dart';

import '../../../../../fixtures/material_wrapper.dart';

void main() {
  setUp(() async => await setup(true));

  group('AuthorizePage', () {
    final Faker faker = Faker();
    final String username = faker.internet.userName();
    final String password = faker.internet.password();
    const Key usernameFindByKey = Key(AppKeys.username);
    const Key passwordFindByKey = Key(AppKeys.password);
    const Duration oneSecond = Duration(seconds: 1);
    const String errorTextLength = 'ab';
    const String usernameEmpty = 'Username can not be empty';
    const String passwordEmpty = 'Password can not be empty';
    const String usernameNotEnoughLong =
        'Username must be at least 3 characters long';
    const String passwordNotEnoughLong =
        'Password must be at least 8 characters long';

    testWidgets('has a Sign In button', (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      expect(
          find.byKey(const Key(AppKeys.signInButton)), equals(findsOneWidget));
    });

    testWidgets('has Username TextFormField and enter username text',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder usernameField = find.descendant(
        of: find.byKey(usernameFindByKey),
        matching: find.byType(EditableText),
      );

      await tester.enterText(usernameField, username);
      expect(find.text(username), equals(findsOneWidget));
    });

    testWidgets('has Password TextFormField and enter password text',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder passwordField = find.descendant(
        of: find.byKey(passwordFindByKey),
        matching: find.byType(EditableText),
      );

      await tester.enterText(passwordField, password);
      expect(find.text(password), equals(findsOneWidget));
    });

    testWidgets('should Password TextFormField is obsecureText',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder passwordField = find.descendant(
        of: find.byKey(passwordFindByKey),
        matching: find.byType(EditableText),
      );

      final EditableText input = tester.widget<EditableText>(passwordField);
      expect(input.obscureText, equals(isTrue));
    });

    testWidgets('should validate Username error if TextFormField empty',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder signInButton = find.byKey(const Key(AppKeys.signInButton));
      final Finder usernameError = find.text(usernameEmpty);

      await tester.tap(signInButton);
      await tester.pump(oneSecond);

      expect(usernameError, equals(findsOneWidget));
    });

    testWidgets('should validate Username error if username not enough long',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder signInButton = find.byKey(const Key(AppKeys.signInButton));
      final Finder usernameError = find.text(usernameNotEnoughLong);
      final Finder usernameField = find.descendant(
        of: find.byKey(usernameFindByKey),
        matching: find.byType(EditableText),
      );

      await tester.enterText(usernameField, errorTextLength);
      await tester.tap(signInButton);
      await tester.pump(oneSecond);

      expect(usernameError, equals(findsOneWidget));
    });

    testWidgets('should validate Password error if TextFormField empty',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder signInButton = find.byKey(const Key(AppKeys.signInButton));
      final Finder passwordError = find.text(passwordEmpty);

      await tester.tap(signInButton);
      await tester.pump(oneSecond);

      expect(passwordError, equals(findsOneWidget));
    });

    testWidgets('should validate Password error if password not enough long',
        (tester) async {
      await tester.pumpWidget(materialWrapper(BlocProvider(
        create: (context) => di<AuthorizeBloc>(),
        child: const AuthorizePage(),
      )));

      final Finder signInButton = find.byKey(const Key(AppKeys.signInButton));
      final Finder passwordError = find.text(passwordNotEnoughLong);
      final Finder passwordField = find.descendant(
        of: find.byKey(passwordFindByKey),
        matching: find.byType(EditableText),
      );

      await tester.enterText(passwordField, errorTextLength);
      await tester.tap(signInButton);
      await tester.pump(oneSecond);

      expect(passwordError, equals(findsOneWidget));
    });

    // testWidgets('show AppSnackBar when state is AuthorizeStatus.failed',
    //     (tester) async {
    //   final AuthorizeEvent event =
    //       AuthorizeDoAuth(AuthParams(username: username, password: password));
    //   when(() => bloc.state)
    //       .thenReturn(const AuthorizeState(status: AuthorizeStatus.failed));
    //   when(() => bloc.add(AuthorizeDoAuth(
    //           AuthParams(username: username, password: password))))
    //       .thenAnswer((_) {});

    //   await tester.pumpWidget(materialWrapper(BlocProvider(
    //     create: (context) => di<AuthorizeBloc>(),
    //     child: const AuthorizePage(),
    //   )));
    //   await tester.tap(find.byKey(const Key(AppKeys.signInButton)));
    //   expect(find.byKey(appSnackBarFindByKey), equals(findsOneWidget));
    //   verify(() => bloc.add(event)).called(1);
    // });
  });
}
