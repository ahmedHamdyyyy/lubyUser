import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/images/image_assets.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../bank_cards/bank_card_screen.dart';
import '../about_loby/about_loby_view.dart';
import '../contact_us/contact_us_view.dart';
import '../host_us/host_with_us_view.dart';
import '../language/language_view.dart';
import '../privacy/privacy_view.dart';
import '../terms_condition/terma_conditions_view.dart';
import '../wallet/wallet_view.dart';
import 'account_screen.dart';
import 'wideget_account.dart';

class ProfileFeaturesScreen extends StatelessWidget {
  const ProfileFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AccountHeaderWidget(),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return AccountCardWidget(
                  state: state,
                  menuItems: [
                    MenuItemWidget(icon: ImageAssets.userIcon, title: "Your Account", screen: const AccountScreen()),
                    MenuItemWidget(icon: ImageAssets.cardIcon, title: "Bank Cards", screen: const BankCardScreen()),
                    MenuItemWidget(icon: ImageAssets.walletIcon, title: "Wallet", screen: const WalletScreen()),
                    MenuItemWidget(icon: ImageAssets.languageIcon, title: "Language", screen: const LanguageView()),
                    MenuItemWidget(icon: ImageAssets.userIcon, title: "Host With Us", screen: const HostWithUsView()),
                    MenuItemWidget(icon: ImageAssets.messageIcon, title: "About Loby", screen: const AboutLobyViewUser()),
                    MenuItemWidget(
                      icon: ImageAssets.tarmsAndConditionsIcon,
                      title: "Terms and Conditions",
                      screen: const TermaConditionsView(),
                    ),
                    MenuItemWidget(icon: ImageAssets.securityIcon, title: "Privacy Policy", screen: const PrivacyView()),
                    MenuItemWidget(icon: ImageAssets.chat2, title: "Contact Us", screen: const ContactUsView()),
                    MenuItemWidget(
                      icon: ImageAssets.rate,
                      title: context.l10n.rateAppTitle,
                      screen: const RateAppScreen(),
                      showArrow: false,
                    ),
                    MenuItemWidget(
                      icon: ImageAssets.invite,
                      title: context.l10n.inviteFriendsTitle,
                      screen: const InviteFriendsScreen(),
                      showArrow: false,
                    ),
                    /*   MenuItemWidget(
                  icon: ImageAssets.logout,
                  title: "Log out",
                  screen: const SignInScreen(),
                  showArrow: false,
                ), */
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
