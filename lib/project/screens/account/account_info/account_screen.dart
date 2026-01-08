// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../config/constants/constance.dart';
import '../../../Home/cubit/home_cubit.dart';
import 'update_account_screen.dart';
import 'wideget_account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isEditing = false;
  String _imageUrl = '';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final nationalIdController = TextEditingController();
  final residenceNumberController = TextEditingController();
  final passportNumberController = TextEditingController();

  void _handleButtonAction() {
    showDeleteAccountDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.getUserStatus == Status.success) {
          firstNameController.text = state.user.firstName;
          lastNameController.text = state.user.lastName;
          phoneController.text = state.user.phone;
          dobController.text =
              state.user.dateOfBirth.length >= 10 ? state.user.dateOfBirth.substring(0, 10) : state.user.dateOfBirth;
          nationalIdController.text = state.user.nationalIdNumber;
          residenceNumberController.text = state.user.residenceNumber;
          passportNumberController.text = state.user.passportNumber;
          _imageUrl = state.user.profilePicture;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AccountInfoAppBar(
              isEditing: isEditing,
              onEditPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAccountScreen(user: state.user)));
              },
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfileHeaderWidget(
                    imageUrl: _imageUrl,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phone: state.user.phone,
                  ),
                  AccountFormFields(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneController: phoneController,
                    dobController: dobController,
                    nationalIdController: nationalIdController,
                    residenceNumberController: residenceNumberController,
                    passportNumberController: passportNumberController,
                    isEditing: isEditing,
                  ),
                  ActionButton(isEditing: isEditing, onPressed: _handleButtonAction),
                ],
              ),
            ),
          );
        } else if (state.getUserStatus == Status.loading || state.getUserStatus == Status.initial) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AccountInfoAppBar(isEditing: isEditing, onEditPressed: () {}),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AccountInfoAppBar(isEditing: isEditing, onEditPressed: () {}),
            body: Center(child: Text(context.l10n.somethingWentWrong)),
          );
        }
      },
    );
  }
}
