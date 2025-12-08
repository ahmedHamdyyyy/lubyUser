// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../../locator.dart';
import '../../../Home/Widget/signin_placeholder.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../models/activity.dart';
import '../../../models/chat.dart';
import '../../../models/property.dart';
import '../../../models/reversation.dart';
import '../../../screens/Complete reservation and payment/all_widget__complete_reservation_and_payment.dart';
import '../../../screens/Complete reservation and payment/thank_you_screen.dart';
import '../../../screens/Conversations/chat_screen.dart';
import '../../../screens/propreties/widgets/show_reserve_dialoge.dart';
import '../../cubit/cubit.dart';
import '../widgets/all_wisget_reservation.dart';

// enum PaymentStatus { initial, loading, paying }

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late int _nights;
  late String _imageUrl, _title, _checkIn, _checkOut, _address;
  late double _price;
  // PaymentStatus _paymentStatus = PaymentStatus.initial;
  // bool _isCheckingPayment = false;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    getIt<ReservationsCubit>().setPayingInitial();
    super.initState();
  }

  void _setDetails(ReservationModel reservation) {
    if (reservation.type == ReservationType.property) {
      final property = reservation.item as PropertyModel;
      _nights = DateTime.parse(reservation.checkOutDate).difference(DateTime.parse(reservation.checkInDate)).inDays;
      _imageUrl = property.medias.firstWhere((m) => !m.endsWith('mp4'));
      _title = property.type;
      _checkIn = reservation.checkInDate.length > 10 ? reservation.checkInDate.substring(0, 10) : reservation.checkInDate;
      _checkOut =
          reservation.checkOutDate.length > 10 ? reservation.checkOutDate.substring(0, 10) : reservation.checkOutDate;
      _price = property.pricePerNight;
      _address = property.address.formattedAddress;
    } else {
      final activity = reservation.item as ActivityModel;
      _nights = 1;
      _imageUrl = activity.medias.firstWhere((m) => !m.endsWith('mp4'));
      _title = activity.name;
      _checkIn = activity.date.length > 10 ? activity.date.substring(0, 10) : activity.date;
      _checkOut = activity.date.length > 10 ? activity.date.substring(0, 10) : activity.date;
      _price = activity.price;
      _address = activity.address.formattedAddress;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed && _paymentStatus == PaymentStatus.paying && !_isCheckingPayment) {
  //     _checkPayment();
  //   }
  // }

  // Future<void> _startPayment() async {
  //   if (_paymentStatus != PaymentStatus.initial) return;
  //   // Guard against rapid taps
  //   setState(() => _paymentStatus = PaymentStatus.loading);
  //   try {
  //     final result = await getIt.get<ReservationsCubit>().initiatePayment(widget.reservation.id);
  //     debugPrint('Payment initiation result: isSuccess=${result.isSuccess}, message=${result.message}');
  //     if (!result.isSuccess) {
  //       setState(() => _paymentStatus = PaymentStatus.initial);
  //       return Utils.errorDialog(context, result.message);
  //     }
  //     final url = result.message;
  //     // Prefer in-app browser to keep user inside app; fallback to external
  //     final launched = await launchUrlString(
  //       url.replaceFirst('https://pay.', 'https://sandbox.'),
  //       mode: LaunchMode.inAppBrowserView,
  //     );
  //     if (!launched) {
  //       // Fallback to external app
  //       final extLaunched = await launchUrlString(url, mode: LaunchMode.externalApplication);
  //       if (!extLaunched) {
  //         setState(() => _paymentStatus = PaymentStatus.initial);
  //         return Utils.errorDialog(context, context.l10n.somethingWentWrong);
  //       }
  //     }
  //     // Mark as paying; user can switch back and press confirm or we auto-check on resume
  //     setState(() => _paymentStatus = PaymentStatus.paying);
  //   } catch (e) {
  //     debugPrint('Start payment error: $e');
  //     setState(() => _paymentStatus = PaymentStatus.initial);
  //     Utils.errorDialog(context, e.toString());
  //   }
  // }

  // Future<void> _checkPayment() async {
  // if (_isCheckingPayment) return;
  // _isCheckingPayment = true;
  // setState(() => _paymentStatus = PaymentStatus.loading);
  // try {
  //   // Try a few times in case backend is slightly delayed
  //   const attempts = 3;
  //   Duration delay = const Duration(seconds: 1);
  //   for (var i = 0; i < attempts; i++) {
  //     final isCompleted = await getIt
  //         .get<ReservationsCubit>()
  //         .checkPaymentStatus(widget.reservation.id)
  //         .timeout(const Duration(seconds: 12), onTimeout: () => false);
  //     if (isCompleted) {
  //       if (!mounted) return;
  //       Navigator.pop(context);
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const ThankYouScreen()));
  //       getIt.get<ReservationsCubit>().updateReservationStatus(widget.reservation.id, ReservationStatus.completed);
  //       _isCheckingPayment = false;
  //       return;
  //     }
  //     if (i < attempts - 1) await Future.delayed(delay);
  //     delay *= 2;
  //   }
  //   // Not completed
  //   if (!mounted) return;
  //   setState(() => _paymentStatus = PaymentStatus.paying);
  //   Utils.errorDialog(context, context.l10n.paymentNotCompleted);
  // } catch (e) {
  //   debugPrint('Check payment error: $e');
  //   if (!mounted) return;
  //   setState(() => _paymentStatus = PaymentStatus.paying);
  //   Utils.errorDialog(context, e.toString());
  // } finally {
  //   _isCheckingPayment = false;
  // }
  // }

  @override
  Widget build(BuildContext context) => PopScope(
    child: Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ReservationsCubit, ReservationsState>(
        builder: (context, state) {
          _setDetails(state.reservation);
          if (state.paymentUrl.isNotEmpty && state.paymentStatus == PaymentStatus.paying) {
            final webViewController =
                WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onNavigationRequest: (request) async {
                        if (request.url.startsWith('https://dashboard.lubyksa.com')) {
                          final isSuccess = await getIt<ReservationsCubit>().checkPaymentStatus();
                          if (isSuccess) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ThankYouScreen()));
                          }
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                    ),
                  )
                  ..loadRequest(Uri.parse(state.paymentUrl));
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) => getIt<ReservationsCubit>().setPayingInitial(),
              child: SafeArea(child: WebViewWidget(controller: webViewController)),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.summaryTitle,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    context.l10n.reservationNumber(state.reservation.registrationNumber),
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10),
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/IMAG.png',
                                      height: 125,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      image: _imageUrl,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 10),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title and price
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: AppColors.secondTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Text(
                                          context.l10n.sarAmount(_price),
                                          style: GoogleFonts.poppins(
                                            color: AppColors.secondTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _address,
                                      style: GoogleFonts.poppins(
                                        color: AppColors.grayTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      state.reservation.type == ReservationType.property
                                          ? "${context.l10n.checkIn} $_checkIn\n${context.l10n.checkOut} $_checkOut"
                                          : "${context.l10n.dateLabel} $_checkIn",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.grayTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.freeCancellationBefore(_checkIn),
                                style: GoogleFonts.poppins(
                                  color: AppColors.secondTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (state.reservation.status == ReservationStatus.draft)
                              IconButton(
                                onPressed: () {
                                  showReseverDialoge(
                                    context,
                                    state.reservation.item as PropertyModel,
                                    _checkIn,
                                    _checkOut,
                                    state.reservation.guestNumber.toString(),
                                  );
                                },
                                icon: SvgPicture.asset(ImageAssets.editIcon),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/saudian_man.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/saudian_man.png', width: 50);
                          },
                          image:
                              state.reservation.item is PropertyModel
                                  ? (state.reservation.item as PropertyModel).vendor.profilePicture
                                  : (state.reservation.item as ActivityModel).vendor.profilePicture,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.hostedBy,
                              style: GoogleFonts.poppins(
                                color: AppColors.secondTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.reservation.item is PropertyModel
                                  ? (state.reservation.item as PropertyModel).vendor.firstName
                                  : (state.reservation.item as ActivityModel).vendor.firstName,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: AppColors.grayTextColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocSelector<HomeCubit, HomeState, bool>(
                        selector: (state) => state.isSignedIn,
                        builder: (context, isSignedIn) {
                          return InkWell(
                            onTap: () async {
                              if (!isSignedIn) {
                                await showSigninPlaceholder(context);
                                return;
                              }
                              final user = getIt<HomeCubit>().state.user;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    final vendor =
                                        state.reservation.item is PropertyModel
                                            ? (state.reservation.item as PropertyModel).vendor
                                            : (state.reservation.item as ActivityModel).vendor;
                                    return ChatScreen(
                                      chat: ChatModel(
                                        id: '${vendor.id}_${user.id}',
                                        vendorId: vendor.id,
                                        vendorName: '${vendor.firstName} ${vendor.lastName}',
                                        vendorImage: vendor.profilePicture,
                                        lastMessage: '',
                                        lastTimestamp: DateTime.now(),
                                        userId: user.id,
                                        userImageUrl: user.profilePicture,
                                        userName: '${user.firstName} ${user.lastName}',
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/images/message-2.svg',
                              // ignore: deprecated_member_use
                              color: const Color(0xFF414141),
                              height: 24,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(height: 32, thickness: 1),
                  Text(
                    context.l10n.summaryTitle,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
                  ),
                  SizedBox(height: 8),
                  SummaryRow(
                    title:
                        state.reservation.type == ReservationType.property
                            ? '$_nights ${context.l10n.nights} × ${context.l10n.sarAmount(_price)}'
                            : '${state.reservation.guestNumber} ${context.l10n.guests} × ${context.l10n.sarAmount(_price)}',
                    price: context.l10n.sarAmount(state.reservation.totalPrice.toStringAsFixed(2)),
                  ),
                  SummaryRow(
                    title: context.l10n.commonVat,
                    price: context.l10n.sarAmount(
                      (state.reservation.totalPrice - state.reservation.totalPriceAfterFees).abs().toStringAsFixed(2),
                    ),
                  ),
                  SummaryRow(
                    title: context.l10n.commonTotal,
                    price: context.l10n.sarAmount(state.reservation.totalPriceAfterFees.toStringAsFixed(2)),
                  ),
                  SizedBox(height: 16),
                  Divider(height: 32, thickness: 1),
                  if (state.paymentStatus == PaymentStatus.error)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        context.l10n.somethingWentWrong,
                        style: GoogleFonts.poppins(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  if (state.reservation.status == ReservationStatus.completed)
                    Row(
                      children: [
                        Image.asset(ImageAssets.pdfIcon, width: 30, height: 30),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            context.l10n.viewReservationSummary,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap:
                              () {}, //=> Navigator.push(context, MaterialPageRoute(builder: (context) => CurretReservationDetailsScreen2())),
                          child: Icon(Icons.arrow_forward_ios, color: AppColors.grayColorIcon),
                        ),
                      ],
                    )
                  else
                    StatefulBuilder(
                      builder: (context, setState) {
                        if (state.paymentStatus == PaymentStatus.loading) {
                          return Center(
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            ),
                          );
                        }
                        return ActionButtonWidget(
                          text: context.l10n.payNow,
                          fontSize: 18,
                          onPressed: () {
                            getIt<ReservationsCubit>().initiatePayment();
                          },
                        );
                      },
                    ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
