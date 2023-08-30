import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixie/cores/constants/app_keys.dart';
import 'package:pixie/cores/utils/di.dart';
import 'package:pixie/features/onboarding/presentations/pages/onboarding_page.dart';

import '../../../../fixtures/material_wrapper.dart';
import '../../../../mocks/fake_route.dart';
import '../../../../mocks/onboarding/mock_navigator_observer.dart';

void main() {
  late MockNavigatorObserver observer;

  setUpAll(() => registerFallbackValue(FakeRoute()));

  setUp(() async {
    await setup(true);
    observer = MockNavigatorObserver();
  });

  group('OnBoardingPage', () {
    testWidgets('has a login button', (tester) async {
      await tester.pumpWidget(materialWrapper(const OnBoardingPage()));

      final Finder loginButton =
          find.byKey(const Key(AppKeys.onBoardingLoginButton));

      expect(loginButton, equals(findsOneWidget));
    });

    testWidgets('login button trigger navigation after tapped', (tester) async {
      await tester.pumpWidget(materialWrapper(const OnBoardingPage()));

      await tester.tap(find.byKey(const Key(AppKeys.onBoardingLoginButton)));
      await tester.pumpAndSettle();

      verifyNever(() => observer.didPush(any(), any()));
    });
  });
}
