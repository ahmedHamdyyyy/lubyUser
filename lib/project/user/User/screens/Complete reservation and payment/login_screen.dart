import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import 'all_widget__complete_reservation_and_payment.dart';
import 'summary_screen.dart';

// Changed from StatelessWidget to StatefulWidget
class LoginScreenAfterHome extends StatefulWidget {
  const LoginScreenAfterHome({super.key});

  @override
  State<LoginScreenAfterHome> createState() => _LoginScreenAfterHomeState();
}

class _LoginScreenAfterHomeState extends State<LoginScreenAfterHome> {
  // Moved the controller to class field
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, "Login", AppColors.primary),
      body: LoginScreenContent(
        phoneController: phoneController,
        isLargeScreen: isLargeScreen,
        onContinuePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SummaryScreen()),
          );
        },
        onEmailPressed: () {
          // Handle email login
        },
        onGooglePressed: () {
          // Handle Google login
        },
        onFacebookPressed: () {
          // Handle Facebook login
        },
      ),
    );
  }
}
