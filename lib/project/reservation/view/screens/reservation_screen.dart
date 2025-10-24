// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../../core/utils/utile.dart';
import '../../../../locator.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../models/activity.dart';
import '../../../models/chat.dart';
import '../../../models/property.dart';
import '../../../models/reversation.dart';
import '../../../profile/screens/Complete reservation and payment/all_widget__complete_reservation_and_payment.dart';
import '../../../profile/screens/Complete reservation and payment/thank_you_screen.dart';
import '../../../profile/screens/Conversations/chat_screen.dart';
import '../../../profile/screens/propreties/widgets/show_reserve_dialoge.dart';
import '../../cubit/cubit.dart';
import '../widgets/all_wisget_reservation.dart';

enum PaymentStatus { initial, loading, paying }

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, required this.reservation});
  final ReservationModel reservation;
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late int _nights;
  late String _imageUrl, _title, _checkIn, _checkOut, _address;
  late double _price;
  PaymentStatus _paymentStatus = PaymentStatus.initial;

  @override
  void initState() {
    if (widget.reservation.type == ReservationType.property) {
      final property = widget.reservation.item as PropertyModel;
      _nights =
          DateTime.parse(widget.reservation.checkOutDate).difference(DateTime.parse(widget.reservation.checkInDate)).inDays;
      _imageUrl = property.medias.firstWhere((m) => !m.endsWith('mp4'));
      _title = property.type;
      _checkIn =
          widget.reservation.checkInDate.length > 10
              ? widget.reservation.checkInDate.substring(0, 10)
              : widget.reservation.checkInDate;
      _checkOut =
          widget.reservation.checkOutDate.length > 10
              ? widget.reservation.checkOutDate.substring(0, 10)
              : widget.reservation.checkOutDate;
      _price = property.pricePerNight;
      _address = property.address.formattedAddress;
    } else {
      final activity = widget.reservation.item as ActivityModel;
      _nights = 1;
      _imageUrl = activity.medias.firstWhere((m) => !m.endsWith('mp4'));
      _title = activity.name;
      _checkIn = activity.date.length > 10 ? activity.date.substring(0, 10) : activity.date;
      _checkOut = activity.date.length > 10 ? activity.date.substring(0, 10) : activity.date;
      _price = activity.price;
      _address = activity.address.formattedAddress;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
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
                  style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              context.l10n.reservationNumber(widget.reservation.registrationNumber),
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
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
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
                                widget.reservation.type == ReservationType.property
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              showReseverDialoge(
                                context,
                                widget.reservation.item as PropertyModel,
                                TextEditingController(text: _checkIn),
                                TextEditingController(text: _checkOut),
                                TextEditingController(text: widget.reservation.guestNumber.toString()),
                              );
                            },
                            icon: SvgPicture.asset(ImageAssets.editIcon),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(ImageAssets.deleteIcon),
                        ],
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
                    imageErrorBuilder:
                        (context, error, stackTrace) => Image.asset('assets/images/saudian_man.png', width: 50),
                    image:
                        widget.reservation.item is PropertyModel
                            ? (widget.reservation.item as PropertyModel).vendor.profilePicture
                            : (widget.reservation.item as ActivityModel).vendor.profilePicture,
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
                        widget.reservation.item is PropertyModel
                            ? (widget.reservation.item as PropertyModel).vendor.firstName
                            : (widget.reservation.item as ActivityModel).vendor.firstName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: AppColors.grayTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    final user = getIt<HomeCubit>().state.user;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          final vendor =
                              widget.reservation.item is PropertyModel
                                  ? (widget.reservation.item as PropertyModel).vendor
                                  : (widget.reservation.item as ActivityModel).vendor;
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
                  widget.reservation.type == ReservationType.property
                      ? '$_nights ${context.l10n.nights} × ${widget.reservation.guestNumber} ${context.l10n.guests} × ${context.l10n.sarAmount(_price)}'
                      : '${widget.reservation.guestNumber} ${context.l10n.guests} × ${context.l10n.sarAmount(_price)}',
              price: context.l10n.sarAmount(widget.reservation.totalPrice),
            ),
            SummaryRow(
              title: context.l10n.commonVat,
              price: context.l10n.sarAmount((widget.reservation.totalPrice - widget.reservation.totalPriceAfterFees).abs()),
            ),
            SummaryRow(
              title: context.l10n.commonTotal,
              price: context.l10n.sarAmount(widget.reservation.totalPriceAfterFees),
            ),
            SizedBox(height: 16),
            Divider(height: 32, thickness: 1),
            if (widget.reservation.status == ReservationStatus.completed)
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
            else if (widget.reservation.status == ReservationStatus.draft)
              StatefulBuilder(
                builder: (context, setState) {
                  if (_paymentStatus == PaymentStatus.loading) {
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
                    onPressed: () async {
                      print('Payment is already in progress or being checked. $_paymentStatus');
                      if (_paymentStatus == PaymentStatus.initial) {
                        // WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() => _paymentStatus = PaymentStatus.initial);
                        // });
                        final result = await getIt.get<ReservationsCubit>().initiatePayment(widget.reservation.id);
                        print('Payment initiation result: isSuccess=${result.isSuccess}, message=${result.message}');
                        if (result.isSuccess) {
                          setState(() => _paymentStatus = PaymentStatus.paying);
                          launchUrlString(
                            result.message.replaceFirst('https://pay.', 'https://sandbox.'),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          setState(() => _paymentStatus = PaymentStatus.initial);
                          Utils.errorDialog(context, result.message);
                        }
                      } else if (_paymentStatus == PaymentStatus.paying) {
                        final isCompleted = await getIt.get<ReservationsCubit>().checkPaymentStatus(widget.reservation.id);
                        if (isCompleted) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYouScreen()));
                          getIt.get<ReservationsCubit>().updateReservationStatus(
                            widget.reservation.id,
                            ReservationStatus.completed,
                          );
                        } else {
                          Utils.errorDialog(context, context.l10n.paymentNotCompleted);
                        }
                      }
                    },
                  );
                },
              )
            else
              Text(
                context.l10n.canceledLabel,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
              ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
