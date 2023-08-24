import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixie/cores/constants/app_routes.dart';
import 'package:pixie/cores/utils/app_navigator.dart';
import 'package:pixie/cores/utils/device.dart';
import 'package:pixie/features/app/presentations/widgets/app_snackbar.dart';
import 'package:pixie/cores/utils/di.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';

class AuthorizePage extends StatefulWidget {
  const AuthorizePage({super.key});

  @override
  State<AuthorizePage> createState() => _AuthorizePageState();
}

class _AuthorizePageState extends State<AuthorizePage> {
  final AppNavigator _nav = di<AppNavigator>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();
  final TextEditingController _usernameCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _usernameCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  void _onSignInButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthorizeBloc>().add(AuthorizeDoAuth(AuthParams(
            username: _usernameCtl.text,
            password: _passwordCtl.text,
            ipAddress: await const Device().getIPAddress(),
          )));
    }
  }

  String? _usernameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Username can not be empty';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: BlocListener<AuthorizeBloc, AuthorizeState>(
          listener: (_, state) {
            if (state.status == AuthorizeStatus.loading) {}

            if (state.status == AuthorizeStatus.success) {
              _nav.pushTo(AppRoutes.dashboard);
            }

            if (state.status == AuthorizeStatus.failed) {
              AppSnackBar.show(context, message: state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const FlutterLogo(size: 100),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameCtl,
                    validator: _usernameValidator,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle_rounded),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordCtl,
                    obscureText: true,
                    validator: _passwordValidator,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _onSignInButtonPressed,
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
