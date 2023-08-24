import 'package:flutter_test/flutter_test.dart';
import 'package:pixie/features/app/presentations/cubits/loading/loading_cubit.dart';

void main() {
  late LoadingCubit cubit;

  setUp(() => cubit = LoadingCubit());

  group('LoadingCubit', () {
    // test('initial state should be LoadingStatus.initial', () {
    //   expect(cubit.state, equals(LoadingStatus.initial));
    // });

    test('initial isLoading should be false', () {
      expect(cubit.state, equals(false));
    });

    test('should setLoading return true', () {
      cubit.setLoading();
      expect(cubit.state, equals(true));
    });
  });
}
