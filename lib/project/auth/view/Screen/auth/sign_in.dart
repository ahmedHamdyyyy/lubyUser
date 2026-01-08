import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../../../locator.dart';
import '../../../cubit/auth_cubit.dart';
import '../../Widget/all_widget_auth.dart';
import 'confirm_otp.dart';
import 'sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _phone = '';

  void _handleLogin() {
    if (_phone.isEmpty) {
      showToast(text: context.l10n.fillAllFields, stute: ToustStute.error);
      return;
    }
    getIt<AuthCubit>().initiateSignin(phone: _phone);
  }

  void _handleCreateAccount() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state.initiateSigninStatus) {
          case Status.initial:
            break;
          case Status.error:
            showToast(text: state.msg, stute: ToustStute.error);
            break;
          case Status.success:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConfirmOtpScreen(phone: _phone, willSignup: false)),
            );
            break;
          default:
            break;
        }
        // switch (state.verifySigninStatus) {
        //   case Status.initial:
        //     break;
        //   case Status.error:
        //     showToast(text: state.msg, stute: ToustStute.error);
        //     break;
        //   case Status.success:
        //     showToast(text: state.msg, stute: ToustStute.success);
        //     WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context, true));
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SignInScreenContent(
              onPhoneChanged: (phone) => _phone = phone,
              onContinue: _handleLogin,
              onCreateAccount: _handleCreateAccount,
              onGoogleContinue: () {},
              onFacebookContinue: () {},
              onGuestLogin: () {},
            ),
            if (state.initiateSigninStatus == Status.loading || state.verifySigninStatus == Status.loading)
              Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
          ],
        );
      },
    ),
  );
}
