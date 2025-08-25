// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/config/widget/widget.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../../Home/cubit/home_cubit.dart';
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

  void _handleButtonAction() {
    showDeleteAccountDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.updateUserStatus == Status.loading) {
          Utils.loadingDialog(context);
        } else if (state.updateUserStatus == Status.success) {
          Navigator.pop(context);
          Navigator.pop(context);
          showToast(text: "Profile updated successfully", stute: ToustStute.success);
        } else if (state.updateUserStatus == Status.error) {
          Navigator.pop(context);
          showToast(text: "Failed to update profile", stute: ToustStute.error);
        }
      },
      builder: (context, state) {
        if (state.getUserStatus == Status.success) {
          firstNameController.text = state.user.firstName;
          lastNameController.text = state.user.lastName;
          phoneController.text = state.user.phone;
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
                    email: state.user.email,
                  ),
                  AccountFormFields(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneController: phoneController,
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
            body: const Center(child: Text("Something went wrong!")),
          );
        }
      },
    );
  }
}
