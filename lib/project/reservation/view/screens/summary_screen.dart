import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/project/Home/Widget/signin_placeholder.dart';
import 'package:luby2/project/models/property.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../../../core/utils/utile.dart';
import '../../../../../locator.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../models/activity.dart';
import '../../../models/reversation.dart';
import '../../../screens/Complete reservation and payment/all_widget__complete_reservation_and_payment.dart';
import '../../../screens/propreties/widgets/show_reserve_dialoge.dart';
import '../../cubit/cubit.dart';
import 'reservation_loader_screen.dart';

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
                    context.l10n.summaryTitle,
                    style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SectionTitleWidget(
                title:
                    widget.reservation.type == ReservationType.property
                        ? context.l10n.reservedProperty
                        : context.l10n.reservedActivity,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 15),
              Builder(
                builder: (context) {
                  final nights =
                      DateTime.parse(
                        widget.reservation.checkOutDate,
                      ).difference(DateTime.parse(widget.reservation.checkInDate)).inDays;
                  if (widget.reservation.type == ReservationType.property) {
                    final item = widget.reservation.item as PropertyModel;
                    return ReservedItemCardWidget(
                      imagePath: item.medias.firstWhere((m) => !m.endsWith('mp4')),
                      title: item.type,
                      location: item.address.formattedAddress,
                      details: item.details,
                      price: item.pricePerNight,
                      totalPrice: widget.reservation.totalPrice,
                      guestNumber: widget.reservation.guestNumber,
                      startDate: widget.reservation.checkInDate,
                      nights: nights,
                      onEdit: () {
                        showReseverDialoge(
                          context,
                          item,
                          widget.reservation.checkInDate,
                          widget.reservation.checkOutDate,
                          widget.reservation.guestNumber.toString(),
                        );
                      },
                      // onDelete: () {},
                    );
                  } else {
                    final item = widget.reservation.item as ActivityModel;
                    return ReservedItemCardWidget(
                      imagePath: item.medias.first,
                      title: item.name,
                      location: item.address.formattedAddress,
                      details: item.details,
                      price: item.price,
                      startDate: widget.reservation.checkInDate,
                      guestNumber: widget.reservation.guestNumber,
                      totalPrice: widget.reservation.totalPrice,
                      nights: nights,
                      onEdit: () => Navigator.pop(context),
                      // onDelete: () {},
                    );
                  }
                },
              ),
              const Divider(),
              const SizedBox(height: 20),
              BlocSelector<HomeCubit, HomeState, bool>(
                selector: (state) => state.isSignedIn,
                builder: (context, isSignedIn) {
                  return ActionButtonWidget(
                    text: context.l10n.saveReservation,
                    onPressed: () async {
                      if (!isSignedIn) {
                        await showSigninPlaceholder(context);
                        return;
                      }
                      if (widget.reservation.id.isEmpty) {
                        getIt<ReservationsCubit>().createReservation(widget.reservation);
                      } else {
                        getIt<ReservationsCubit>().updateReservation(widget.reservation);
                      }
                    },
                    fontSize: 18,
                  );
                },
              ),
              const SizedBox(height: 24),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationLoaderScreen(reservationId: message)));
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
