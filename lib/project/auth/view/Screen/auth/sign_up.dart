import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../models/user.dart';
import '../../../../screens/account/terms_condition/terms_services.dart';
import '../../../cubit/auth_cubit.dart';
import '../../Widget/phone_field.dart';
import '../../Widget/wideget_sign_up.dart';
import 'confirm_otp.dart';
import 'sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  String _phone = '';

  bool agreeToTerms = false;
  File? profileImage;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.agreeToTerms), backgroundColor: Colors.red));
      return;
    }
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        _phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.fillAllFields), backgroundColor: Colors.red));
      return;
    }

    context.read<AuthCubit>().initiateSignup(_phone.trim());
  }

  void _handleImageSelected(File image) => setState(() => profileImage = image);

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      switch (state.initiateSignupStatus) {
        case Status.initial:
          break;
        case Status.error:
          showToast(text: state.msg, stute: ToustStute.error);
          break;
        case Status.success:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ConfirmOtpScreen(
                  user: UserModel.initial.copyWith(
                    firstName: firstNameController.text.trim(),
                    lastName: lastNameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: _phone,
                    profilePicture: profileImage == null ? '' : profileImage!.path,
                  ),
                  phone: _phone,
                  willSignup: true,
                );
              },
            ),
          );
          break;
        default:
          break;
      }
    },
    builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SignUpHeader(),
                      const SizedBox(height: 24),
                      EditableProfileImage(onImageSelected: _handleImageSelected),
                      const SizedBox(height: 38),
                      RegistrationTextField(
                        hintText: context.l10n.firstNameLabel,
                        controller: firstNameController,
                        isError: false,
                      ),
                      RegistrationTextField(hintText: context.l10n.lastNameLabel, controller: lastNameController),
                      RegistrationTextField(hintText: context.l10n.emailLabel, controller: emailController),
                      PhoneField(onChanged: (phone) => _phone = phone),
                      const SizedBox(height: 16),
                      TermsConditionsbox(onChanged: (value) => agreeToTerms = value),
                      const SizedBox(height: 10),
                      SignUpButton(onPressed: _handleSignUp),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.alreadyHaveAccount,
                            style: GoogleFonts.poppins(
                              color: AppColors.grayTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const SignInScreen()),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              context.l10n.signIn,
                              style: GoogleFonts.poppins(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              if (state.initiateSignupStatus == Status.loading)
                Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      );
    },
  );
}
