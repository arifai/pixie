import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixie/cores/utils/device.dart';
import 'package:pixie/cores/widgets/app_snackbar.dart';
import 'package:pixie/features/authorize/domains/usecases/authorize_usecase.dart';
import 'package:pixie/features/authorize/presentations/bloc/authorize_bloc.dart';

class AuthorizePage extends StatefulWidget {
  const AuthorizePage({super.key});

  @override
  State<AuthorizePage> createState() => _AuthorizePageState();
}

class _AuthorizePageState extends State<AuthorizePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: BlocListener<AuthorizeBloc, AuthorizeState>(
          listener: (_, state) {
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
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordCtl,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 20),
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
