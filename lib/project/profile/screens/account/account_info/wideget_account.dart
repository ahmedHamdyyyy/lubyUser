// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luby2/locator.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/images/image_assets.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../auth/cubit/auth_cubit.dart';
import '../../../../auth/view/Screen/auth/sign_in.dart';

// Account App Bar widget
class AccountInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditing;
  final VoidCallback onEditPressed;

  const AccountInfoAppBar({super.key, required this.isEditing, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Account info",
        style: TextStyle(color: AppColors.grayTextColor, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
      ),
      centerTitle: false,
      actions: [if (!isEditing) IconButton(icon: SvgPicture.asset(ImageAssets.editIcon), onPressed: onEditPressed)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Profile Header Widget (Avatar and name)
class ProfileHeaderWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FadeInImage.assetNetwork(
            placeholder: ImageAssets.profileImage,
            image: imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(ImageAssets.profileImage),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "$firstName $lastName",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontFamily: 'Poppins',
          ),
        ),
        Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400)),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final bool isPassword;

  const CustomTextField({super.key, required this.controller, required this.isEnabled, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: TextField(
          controller: controller,
          enabled: isEnabled,
          obscureText: isPassword,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.grayTextColor,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grayColorIcon),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grayColorIcon),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grayColorIcon),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grayColorIcon),
            ),
          ),
        ),
      ),
    );
  }
}

// Action Button Widget
class ActionButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.isEditing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            isEditing ? "Save" : "Delete Account",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}

// Delete Account Dialog Widget
class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Delete Account",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 1.2,
              width: 120,
              color: AppColors.primaryColor,
            ),
            const Text(
              "Are you sure about deleting your account?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondTextColor,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // هنا تحط عملية حذف الحساب
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show delete account dialog
void showDeleteAccountDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const DeleteAccountDialog());
}

// Account Form Fields Widget
class AccountFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final bool isEditing;

  const AccountFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(controller: firstNameController, isEnabled: isEditing),
        CustomTextField(controller: lastNameController, isEnabled: isEditing),
        CustomTextField(controller: phoneController, isEnabled: isEditing),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ----- New Account Screen Widgets -----

// Account Header Widget
class AccountHeaderWidget extends StatelessWidget {
  const AccountHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 52),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Account",
                style: TextStyle(
                  color: AppColors.grayTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),

            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.signoutStatus == Status.success) {
                  showToast(text: state.msg, stute: ToustStute.success);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    getIt<AuthCubit>().signout();
                  },
                  icon: state.signoutStatus == Status.loading ? const CircularProgressIndicator() : const Icon(Icons.logout),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// Account Profile Card Widget
class AccountProfileCardWidget extends StatelessWidget {
  const AccountProfileCardWidget({super.key, required this.state});
  final HomeState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            state.user.profilePicture,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${state.user.firstName} ${state.user.lastName}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.accountTextColor,
            fontFamily: 'Poppins',
          ),
        ),
        Text(state.user.email, style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Poppins')),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Menu Item Widget
class MenuItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? screen;
  final bool showArrow;

  const MenuItemWidget({super.key, required this.icon, required this.title, required this.screen, this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 24, height: 24),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: showArrow ? 16 : 14,
          color: AppColors.accountTextColor,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: showArrow ? SvgPicture.asset(ImageAssets.arrowDown, height: 24, width: 24) : null,
      onTap: () {
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
        }
      },
    );
  }
}

// Account Card Widget
class AccountCardWidget extends StatelessWidget {
  final List<Widget> menuItems;
  final HomeState state;

  const AccountCardWidget({super.key, required this.menuItems, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 5, spreadRadius: 1)],
      ),
      child: Column(children: [AccountProfileCardWidget(state: state), ...menuItems, const SizedBox(height: 20)]),
    );
  }
}

// Placeholder Screen Widget
class PlaceholderScreenWidget extends StatelessWidget {
  final String title;

  const PlaceholderScreenWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, title, AppColors.grayTextColor),
      body: const Center(
        child: Text("Coming Soon...", style: TextStyle(fontSize: 20, color: Colors.grey, fontFamily: 'Poppins')),
      ),
    );
  }
}

// Placeholder screen classes
class RateAppScreen extends StatelessWidget {
  const RateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreenWidget(title: "Rate App");
  }
}

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreenWidget(title: "Invite Friends");
  }
}

// ----- Your Account Screen Widgets -----

// Account Info Header
class AccountInfoHeader extends StatelessWidget {
  const AccountInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon)),
            const SizedBox(width: 8),
            Text(
              "Account info",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "Please complete the following\ninformation",
          style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

// Editable Profile Image
class EditableProfileImage extends StatefulWidget {
  const EditableProfileImage({super.key, required this.image, required this.onImageChanged});
  final String image;
  final ValueChanged<String> onImageChanged;
  @override
  State<EditableProfileImage> createState() => _EditableProfileImageState();
}

class _EditableProfileImageState extends State<EditableProfileImage> {
  String imagePath = '';
  @override
  void initState() {
    imagePath = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child:
              imagePath.startsWith('http')
                  ? FadeInImage.assetNetwork(
                    placeholder: ImageAssets.profileImage,
                    image: imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage(ImageAssets.profileImage),
                      );
                    },
                  )
                  : imagePath.isEmpty
                  ? Image.asset(ImageAssets.profileImage, width: 100, height: 100, fit: BoxFit.cover)
                  : Image.file(File(imagePath), width: 100, height: 100, fit: BoxFit.cover),
        ),
        if (imagePath.isNotEmpty)
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() => imagePath = '');
                widget.onImageChanged(imagePath);
              },
              child: Icon(Icons.remove_circle, color: Colors.red),
            ),
          ),
        Positioned(
          bottom: 5,
          right: 5,
          child: InkWell(
            onTap: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() => imagePath = pickedFile.path);
                widget.onImageChanged(imagePath);
              }
            },
            child: SvgPicture.asset('assets/svg/edit.svg', width: 24, height: 24),
          ),
        ),
      ],
    );
  }
}

// Profile Info Text
class ProfileInfoText extends StatelessWidget {
  const ProfileInfoText({super.key, required this.firstName, required this.lastName, required this.email});
  final String firstName;
  final String lastName;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          "$firstName $lastName",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.accountTextColor,
          ),
        ),
        Text(email, style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400)),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Registration TextField
class RegistrationTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final bool isNumber;
  final bool isError;
  final TextEditingController controller;
  final bool enabled;
  const RegistrationTextField({
    super.key,
    this.enabled = true,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isNumber = false,
    this.isError = false,
  });

  @override
  State<RegistrationTextField> createState() => _RegistrationTextFieldState();
}

class _RegistrationTextFieldState extends State<RegistrationTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: widget.isError ? AppColors.primaryColor : Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: widget.isPassword ? !isVisible : false,
        keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  )
                  : null,
        ),
      ),
    );
  }
}

// Terms Checkbox
class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const TermsCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child:
              value
                  ? SvgPicture.asset(ImageAssets.cracalBlack, width: 20, height: 20)
                  : SvgPicture.asset(ImageAssets.cracalWhite, width: 20, height: 20),
        ),
        const SizedBox(width: 10),
        const Text(
          "Agree to the terms and conditions",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// Save Button
class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: const Text(
          "Save",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
