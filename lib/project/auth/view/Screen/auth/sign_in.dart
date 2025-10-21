import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../../../locator.dart';
import '../../../../Home/ui/home_screen.dart';
import '../../../cubit/auth_cubit.dart';
import '../../Widget/all_widget_auth.dart';
import 'sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  @override
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      showToast(text: context.l10n.fillAllFields, stute: ToustStute.error);
      return;
    }
    getIt<AuthCubit>().signin(email: email, password: password);
  }

  void _handleCreateAccount() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state.signinStatus) {
          case Status.initial:
            break;
          case Status.error:
            showToast(text: state.msg, stute: ToustStute.error);
            break;
          case Status.success:
            showToast(text: state.msg, stute: ToustStute.success);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                LoginScreenContent(
                  emailController: emailController,
                  passwordController: passwordController,
                  obscurePassword: obscurePassword,
                  onTogglePassword: () => setState(() => obscurePassword = !obscurePassword),
                  onContinue: _handleLogin,
                  onCreateAccount: _handleCreateAccount,
                  onGoogleContinue: () {},
                  onFacebookContinue: () {},
                  onGuestLogin: () {},
                ),
                if (state.signinStatus == Status.loading)
                  Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
              ],
            );
          },
        ),
      ),
    );
  }
}
