// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../config/colors/colors.dart';
import '../../../locator.dart';
import '../../auth/view/Screen/auth/sign_in.dart';
import '../cubit/home_cubit.dart';

Future<bool?> showSigninPlaceholder(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: SigninPlaceholder(onLoginSuccessfuly: () => Navigator.of(context).pop(true)),
        ),
      );
    },
  );
}

Future<bool> _signin(BuildContext context) async {
  final bool? isLoggedIn = await Navigator.push(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
  if (isLoggedIn != true) return false;
  // Update the user data asynchronously
  getIt<HomeCubit>().fetchUser();
  return true;
}

class SigninPlaceholder extends StatelessWidget {
  const SigninPlaceholder({super.key, required this.onLoginSuccessfuly});
  final void Function() onLoginSuccessfuly;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.loginToGetThisFeature,
          style: TextStyle(color: AppColors.primaryTextColor, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () async {
            final isSuccess = await _signin(context);
            if (isSuccess) onLoginSuccessfuly();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            context.l10n.signIn,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
