import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixie/cores/utils/di.dart';
import 'package:pixie/features/app/presentations/widgets/app_snackbar.dart';

import '../../../../fixtures/material_wrapper.dart';

void main() {
  setUp(() => setup(true));

  group('AppSnackBar', () {
    const String text = 'Hello';
    const String snackBar = 'SnackBar Test';
    const Key key = Key('__tap_target__');

    void onTappedSnackBarVoid(BuildContext context) =>
        AppSnackBar.show(context, message: snackBar);
    dynamic onTappedSnackBarDynamic(BuildContext context) =>
        AppSnackBar.build(context, message: snackBar);

    Widget bodyTester([bool isBuild = false]) {
      return Scaffold(
        body: Builder(
          builder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                isBuild
                    ? onTappedSnackBarDynamic(context)
                    : onTappedSnackBarVoid(context);
              },
              child: const Text('Tapped', key: key),
            );
          },
        ),
      );
    }

    testWidgets('has text inside GestureDetector', (tester) async {
      await tester.pumpWidget(materialWrapper(bodyTester()));

      expect(find.text(text), equals(findsNothing));
    });

    testWidgets('should show AppSnackBar from void when GestureDetector tapped',
        (tester) async {
      await tester.pumpWidget(materialWrapper(bodyTester()));
      await tester.tap(find.byKey(key));
      await tester.pump(const Duration(seconds: 3));

      expect(find.text(snackBar), equals(findsOneWidget));
    });

    testWidgets(
        'should show AppSnackBar from build when GestureDetector tapped',
        (tester) async {
      await tester.pumpWidget(materialWrapper(bodyTester(true)));
      await tester.tap(find.byKey(key));
      await tester.pump(const Duration(seconds: 3));

      expect(find.text(snackBar), equals(findsOneWidget));
    });
  });
}
