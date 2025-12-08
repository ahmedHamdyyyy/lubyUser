import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../config/images/image_assets.dart';
import '../../../../config/constants/constance.dart';
import '../../../../config/widget/widget.dart';
import '../../../../locator.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../about_loby/about_loby_view.dart';
import '../contact_us/contact_us_view.dart';
import '../host_us/host_with_us_view.dart';
import '../language/language_view.dart';
import '../privacy/privacy_view.dart';
import '../terms_condition/terma_conditions_view.dart';
import 'account_screen.dart';
import 'wideget_account.dart';

class ProfileFeaturesScreen extends StatelessWidget {
  const ProfileFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return AccountCardWidget(
                    state: state,
                    menuItems: [
                      MenuItemWidget(
                        icon: ImageAssets.userIcon,
                        title: context.l10n.accountInfoTitle,
                        screen: const AccountScreen(),
                        checkLoginFirst: true,
                      ),
                      // MenuItemWidget(icon: ImageAssets.cardIcon, title: "Bank Cards", screen: const BankCardScreen()),
                      // MenuItemWidget(icon: ImageAssets.walletIcon, title: "Wallet", screen: const WalletScreen()),
                      MenuItemWidget(
                        icon: ImageAssets.languageIcon,
                        title: context.l10n.language,
                        screen: const LanguageView(),
                      ),
                      MenuItemWidget(
                        icon: ImageAssets.userIcon,
                        title: context.l10n.hostWithUsTitle,
                        screen: const HostWithUsView(),
                      ),
                      MenuItemWidget(
                        icon: ImageAssets.messageIcon,
                        title: context.l10n.aboutLobyTitle,
                        screen: const AboutLobyViewUser(),
                      ),
                      MenuItemWidget(
                        icon: ImageAssets.tarmsAndConditionsIcon,
                        title: context.l10n.termsAndConditionsTitle,
                        screen: const TermsConditionsView(),
                      ),
                      MenuItemWidget(
                        icon: ImageAssets.securityIcon,
                        title: context.l10n.privacyPolicyTitle,
                        screen: const PrivacyView(),
                      ),
                      MenuItemWidget(
                        icon: ImageAssets.chat2,
                        title: context.l10n.contactUsTitle,
                        screen: const ContactUsView(),
                      ),
                      MenuItemWidget(
                        icon: ImageAssets.rate,
                        title: context.l10n.rateAppTitle,
                        screen: const RateAppScreen(),
                        showArrow: false,
                      ),
                      // MenuItemWidget(
                      //   icon: ImageAssets.invite,
                      //   title: context.l10n.inviteFriendsTitle,
                      //   screen: const InviteFriendsScreen(),
                      //   showArrow: false,
                      // ),
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

              BlocSelector<HomeCubit, HomeState, bool>(
                selector: (state) => state.isSignedIn,
                builder: (context, isSignedIn) {
                  return BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.signoutStatus == Status.success) {
                        showToast(text: state.msg, stute: ToustStute.success);
                        getIt<HomeCubit>().clearUserData();
                        getIt<HomeCubit>().checkSignin();
                      }
                    },
                    builder: (context, state) {
                      if (!isSignedIn) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: IconButton(
                          onPressed: getIt<AuthCubit>().signout,
                          icon:
                              state.signoutStatus == Status.loading
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.logout),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
