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

enum IdentityType { citizen, resident, visitor }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final idNumberController = TextEditingController();
  IdentityType? _identityType;

  String _phone = '';

  bool agreeToTerms = false;
  File? profileImage;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    idNumberController.dispose();
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
        dobController.text.isEmpty ||
        _phone.isEmpty ||
        _identityType == null ||
        idNumberController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.fillAllFields), backgroundColor: Colors.red));
      return;
    }

    context.read<AuthCubit>().initiateSignup(
      UserModel.initial.copyWith(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: _phone,
        profilePicture: profileImage == null ? '' : profileImage!.path,
        dateOfBirth: dobController.text.trim(),
        nationalIdNumber: _identityType == IdentityType.citizen ? idNumberController.text.trim() : '',
        residenceNumber: _identityType == IdentityType.resident ? idNumberController.text.trim() : '',
        passportNumber: _identityType == IdentityType.visitor ? idNumberController.text.trim() : '',
      ),
    );
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
                    dateOfBirth: dobController.text.trim(),
                    nationalIdNumber: _identityType == IdentityType.citizen ? idNumberController.text.trim() : '',
                    residenceNumber: _identityType == IdentityType.resident ? idNumberController.text.trim() : '',
                    passportNumber: _identityType == IdentityType.visitor ? idNumberController.text.trim() : '',
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
                      Text(
                        context.l10n.firstName,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RegistrationTextField(
                        hintText: context.l10n.firstNameLabel,
                        controller: firstNameController,
                        isError: false,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.lastName,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RegistrationTextField(hintText: context.l10n.lastNameLabel, controller: lastNameController),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.emailLabel,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RegistrationTextField(hintText: context.l10n.emailLabel, controller: emailController),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.dateOfBirthLabel,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              dobController.text =
                                  '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: RegistrationTextField(
                            hintText: 'YYYY-MM-DD',
                            controller: dobController,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                      // Identity type selection
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.phone,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      PhoneField(onChanged: (phone) => _phone = phone),
                      const SizedBox(height: 32),
                      Text(
                        context.l10n.identityTypeSelect,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RadioListTile<IdentityType>(
                        title: Text(context.l10n.saudiCitizen),
                        value: IdentityType.citizen,
                        groupValue: _identityType,
                        onChanged: (val) => setState(() => _identityType = val),
                      ),
                      RadioListTile<IdentityType>(
                        title: Text(context.l10n.residentInSaudi),
                        value: IdentityType.resident,
                        groupValue: _identityType,
                        onChanged: (val) => setState(() => _identityType = val),
                      ),
                      RadioListTile<IdentityType>(
                        title: Text(context.l10n.visitor),
                        value: IdentityType.visitor,
                        groupValue: _identityType,
                        onChanged: (val) => setState(() => _identityType = val),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _identityType == IdentityType.citizen
                            ? context.l10n.nationalIdNumberLabel
                            : _identityType == IdentityType.resident
                            ? context.l10n.residenceNumberLabel
                            : context.l10n.passportNumberLabel,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RegistrationTextField(
                        hintText:
                            _identityType == IdentityType.citizen
                                ? context.l10n.nationalIdNumberLabel
                                : _identityType == IdentityType.resident
                                ? context.l10n.residenceNumberLabel
                                : context.l10n.passportNumberLabel,
                        controller: idNumberController,
                        keyboardType: _identityType == IdentityType.visitor ? TextInputType.text : TextInputType.number,
                      ),
                      TermsConditionsbox(onChanged: (isAgreed) => agreeToTerms = isAgreed),
                      const SizedBox(height: 16),
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
