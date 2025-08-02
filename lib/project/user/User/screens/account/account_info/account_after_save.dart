// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'wideget_account.dart';

class AccountAfterSaveScreen extends StatefulWidget {
  const AccountAfterSaveScreen({super.key});

  @override
  _AccountAfterSaveScreenState createState() => _AccountAfterSaveScreenState();
}

class _AccountAfterSaveScreenState extends State<AccountAfterSaveScreen> {
  bool isEditing = false;

  final TextEditingController firstNameController =
      TextEditingController(text: "Mostafa");
  final TextEditingController lastNameController =
      TextEditingController(text: "Abdallah");
  final TextEditingController phoneController =
      TextEditingController(text: "+966 123456789");
  final TextEditingController emailController =
      TextEditingController(text: "info@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "********");

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _handleButtonAction() {
    if (isEditing) {
      setState(() {
        isEditing = false;
      });
    } else {
      showDeleteAccountDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountInfoAppBar(
        isEditing: isEditing,
        onEditPressed: _toggleEditMode,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ProfileHeaderWidget(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
            ),
            AccountFormFields(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              phoneController: phoneController,
              emailController: emailController,
              passwordController: passwordController,
              isEditing: isEditing,
            ),
            ActionButton(
              isEditing: isEditing,
              onPressed: _handleButtonAction,
            ),
          ],
        ),
      ),
    );
  }
}
