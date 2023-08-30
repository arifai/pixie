import 'package:flutter/material.dart';
import 'package:pixie/cores/constants/app_keys.dart';
import 'package:pixie/cores/constants/app_routes.dart';
import 'package:pixie/cores/utils/app_navigator.dart';
import 'package:pixie/cores/utils/di.dart';
import 'package:pixie/features/onboarding/presentations/widgets/half_rounded.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppNavigator nav = di<AppNavigator>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HalfRounded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                      image: AssetImage('assets/images/work.jpg'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 6),
                child: Text(
                  'Welcome to Pixie!',
                  style: textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Text(
                  'This is the default template of Pixie',
                  style: textTheme.titleSmall,
                ),
              ),
              Center(
                child: ElevatedButton(
                  key: const Key(AppKeys.onBoardingLoginButton),
                  onPressed: () => nav.navigateTo(AppRoutes.authorize),
                  child: Text('Login', style: textTheme.labelLarge),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have have an account yet? ',
                      children: [
                        TextSpan(
                          text: 'Register here',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
