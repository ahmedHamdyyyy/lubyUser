// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Home/cubit/home_cubit.dart';
import 'account_after_save.dart';
import 'wideget_account.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool agreeToTerms = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        firstNameController.text = state.user.firstName;
        lastNameController.text = state.user.lastName;
        phoneController.text = state.user.phone;
        emailController.text = state.user.email;
        return  Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AccountInfoHeader(),
                const SizedBox(height: 15),
                EditableProfileImage(image: state.user.profilePicture ),
                ProfileInfoText(firstName: state.user.firstName, lastName: state.user.lastName, email: state.user.email),
                RegistrationTextField(
                  controller: firstNameController,
                  hintText: state.user.firstName,
                  isError: false,
                ),
                RegistrationTextField(
                  controller: lastNameController,
                  hintText: state.user.lastName,
                  isError: false,
                ),
                RegistrationTextField(
                  controller: phoneController,
                  hintText: state.user.phone,
                  isNumber: true,
                  isError: false,
                ),
                RegistrationTextField(
                  enabled: false,
                  controller: emailController,
                  hintText: state.user.email,
                  isError: false,
                ),
    /*                   RegistrationTextField(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                  isError: false,
                ),
                RegistrationTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                  isError: false,
                ), */
                const SizedBox(height: 10),
                TermsCheckbox(
                  value: agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      agreeToTerms = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SaveButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountAfterSaveScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}
