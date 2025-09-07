import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/project/models/property.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/utils/utile.dart';
import '../../../../../locator.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../models/activity.dart';
import '../../../models/reversation.dart';
import '../../../reservation/cubit/cubit.dart';
import '../propreties/widgets/show_reserve_dialoge.dart';
import 'all_widget__complete_reservation_and_payment.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key, required this.reservation});
  final ReservationModel reservation;
  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isApplied = false, showSuccessMessage = false;
  final _promoCodeController = TextEditingController();

  @override
  void initState() {
    getIt<ReservationsCubit>().initStatus();
    super.initState();
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationsCubit, ReservationsState>(
      listener: (context, state) {
        _handleStatus(state.createReservationStatus, state.message, context);
        _handleStatus(state.updateReservationStatus, state.message, context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Summary",
                    style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SectionTitleWidget(
                title: "Reserved ${widget.reservation.type == ReservationType.property ? "Property" : "Activity"}",
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 15),
              Builder(
                builder: (context) {
                  if (widget.reservation.type == ReservationType.property) {
                    final item = widget.reservation.item as PropertyModel;
                    final nights =
                        DateTime.parse(
                          widget.reservation.checkOutDate,
                        ).difference(DateTime.parse(widget.reservation.checkInDate)).inDays;
                    return ReservedItemCardWidget(
                      imagePath: item.medias.first,
                      title: item.type,
                      location: item.address.formattedAddress,
                      dateDetails: item.details,
                      price: item.pricePerNight,
                      totalPrice: widget.reservation.totalPrice.toInt(),
                      guestNumber: widget.reservation.guestNumber,
                      nights: nights,
                      onEdit: () {
                        showReseverDialoge(
                          context,
                          item,
                          TextEditingController(text: widget.reservation.checkInDate),
                          TextEditingController(text: widget.reservation.checkOutDate),
                          TextEditingController(text: widget.reservation.guestNumber.toString()),
                        );
                      },
                      // onDelete: () {},
                    );
                  } else {
                    final item = widget.reservation.item as ActivityModel;
                    return ReservedItemCardWidget(
                      imagePath: item.medias.first,
                      title: item.name,
                      location: item.address,
                      dateDetails: item.details,
                      price: item.price,
                      guestNumber: widget.reservation.guestNumber,
                      totalPrice: widget.reservation.totalPrice.toInt(),
                      nights: 5, //-----------------------
                      onEdit: () => Navigator.pop(context),
                      // onDelete: () {},
                    );
                  }
                },
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PromoCodeInputWidget(
                  //   controller: _promoCodeController,
                  //   buttonText: isApplied ? "Apply" : "Submit",
                  //   hintText: "Enter the promo code",
                  //   isApplied: isApplied,
                  //   onApplyPressed: () {
                  //     setState(() {
                  //       isApplied = true;
                  //       showSuccessMessage = true;
                  //     });
                  //   },
                  // ),
                  // if (showSuccessMessage) PromoCodeSuccessMessageWidget(),
                  // const SizedBox(height: 20),
                  // const SummaryRowWidget(title: "Total", value: "1000 SAR"),
                  // if (isApplied)
                  //   DiscountRowWidget(
                  //     discountText: "After Discount",
                  //     savedAmount: "(You Saved 100 SAR)",
                  //     finalPrice: "900 SAR",
                  //   ),
                  const SizedBox(height: 20),
                  ActionButtonWidget(
                    text: "Save Reservation",
                    onPressed: () {
                      if (widget.reservation.id.isEmpty) {
                        getIt<ReservationsCubit>().createReservation(widget.reservation);
                      } else {
                        getIt<ReservationsCubit>().updateReservation(widget.reservation);
                      }
                    },
                    fontSize: 18,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStatus(Status status, String message, BuildContext context) {
    switch (status) {
      case Status.loading:
        Utils.loadingDialog(context);
        break;
      case Status.success:
        Navigator.pop(context);
        Navigator.pop(context);
        getIt<HomeCubit>().updateCurrentScreenIndex(2);
        break;
      case Status.error:
        Navigator.pop(context);
        Utils.errorDialog(context, message);
        break;
      default:
        break;
    }
  }
}
