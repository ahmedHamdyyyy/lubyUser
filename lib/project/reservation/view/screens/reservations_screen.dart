import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../locator.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../Home/Widget/signin_placeholder.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../models/activity.dart';
import '../../../models/property.dart';
import '../../../models/reversation.dart';
import '../../cubit/cubit.dart';
import 'reservation_screen.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});
  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  ReservationsFilterType _filterType = ReservationsFilterType.draft;
  final _scrollController = ScrollController();
  // Removed local loading flag; derive directly from cubit state inside the builder to avoid rebuild loops
  bool _isLoggedIn = false;
  @override
  void initState() {
    _fetchReservations();
    _handleFetchModeItems();
    super.initState();
  }

  void _fetchReservations() {
    _isLoggedIn = getIt<HomeCubit>().state.isSignedIn;
    if (_isLoggedIn) getIt<ReservationsCubit>().getReservations(_filterType);
  }

  void _handleFetchModeItems() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (_isLoggedIn) getIt<ReservationsCubit>().getReservations(_filterType, fetchNext: true);
      }
    });
  }

  void _setFilter(ReservationsFilterType type) {
    if (_filterType != type) {
      setState(() => _filterType = type);
      _fetchReservations();
    }
  }

  void _onLogin() {
    setState(() => _isLoggedIn = true);
    _fetchReservations();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.isSignedIn != current.isSignedIn,
      builder: (context, state) {
        _isLoggedIn = state.isSignedIn;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 66, bottom: 8),
              child: Text(
                context.l10n.reservationsTitle,
                style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 12, right: 18, left: 18),
              child: Row(
                children: [
                  Expanded(
                    child: buildTabButton(
                      text: context.l10n.tabPending,
                      isSelected: _filterType == ReservationsFilterType.draft,
                      onTap: () => _setFilter(ReservationsFilterType.draft),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: buildTabButton(
                      text: context.l10n.tabCurrent,
                      isSelected: _filterType == ReservationsFilterType.current,
                      onTap: () => _setFilter(ReservationsFilterType.current),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: buildTabButton(
                      text: context.l10n.tabLast,
                      isSelected: _filterType == ReservationsFilterType.last,
                      onTap: () => _setFilter(ReservationsFilterType.last),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  state.isSignedIn
                      ? BlocBuilder<ReservationsCubit, ReservationsState>(
                        builder: (context, state) {
                          // Avoid triggering setState inside build; derive loading flag directly
                          final bool isLoadingMore = state.getReservationsStatus == Status.loading;
                          final properties = state.reservations.where((r) => r.type == ReservationType.property).toList();
                          final activities = state.reservations.where((r) => r.type == ReservationType.activity).toList();

                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context.l10n.propertiesSection, style: TextTheme.of(context).titleLarge),
                                  SizedBox(height: 8),
                                  if (properties.isEmpty)
                                    _buildEmptyState(
                                      icon: Icons.home,
                                      title: context.l10n.noPropertyReservations,
                                      subtitle: context.l10n.noCurrentPropertyReservations,
                                    )
                                  else
                                    ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      itemCount: properties.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) {
                                        final reservation = properties[index];
                                        final item = properties[index].item as PropertyModel;
                                        return Card(
                                          color: Colors.white,
                                          elevation: 0,
                                          margin: const EdgeInsets.only(bottom: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox.square(
                                                    dimension: 135,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: FadeInImage.assetNetwork(
                                                        placeholder: 'assets/images/IMAG.png',
                                                        image: item.medias.firstWhere(
                                                          (m) => !m.endsWith('mp4'),
                                                          orElse: () => '',
                                                        ),
                                                        height: 150,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                item.type,
                                                                maxLines: 2,
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: AppColors.primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                            if (_filterType == ReservationsFilterType.draft)
                                                              IconButton(
                                                                onPressed:
                                                                    () => getIt<ReservationsCubit>().removeReservation(
                                                                      reservation.id,
                                                                    ),
                                                                icon: Icon(Icons.delete),
                                                              ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          item.address.formattedAddress,
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            color: AppColors.grayTextColor,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color: AppColors.secondTextColor,
                                                            ),
                                                            children: [
                                                              const TextSpan(
                                                                text: 'check in ',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14,
                                                                  color: AppColors.secondTextColor,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: reservation.checkInDate.substring(0, 10),
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  color: AppColors.grayTextColor,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color: AppColors.secondTextColor,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: 'check out ',
                                                                style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14,
                                                                  color: AppColors.secondTextColor,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: reservation.checkOutDate.substring(0, 10),
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  color: AppColors.grayTextColor,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  getIt<ReservationsCubit>().setReservation(reservation);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ReservationScreen()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.primaryColor,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                  minimumSize: Size(double.infinity, 35),
                                                ),
                                                child: Text(context.l10n.viewReservationDetails),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  SizedBox(height: 64),
                                  Text(context.l10n.activitiesSection, style: TextTheme.of(context).titleLarge),
                                  SizedBox(height: 8),
                                  if (activities.isEmpty)
                                    _buildEmptyState(
                                      icon: Icons.star_rounded,
                                      title: context.l10n.noActivityReservations,
                                      subtitle: context.l10n.noCurrentActivityReservations,
                                    )
                                  else
                                    ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      itemCount: activities.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) {
                                        final reservation = activities[index];
                                        final activity = reservation.item as ActivityModel;
                                        return Card(
                                          color: Colors.white,
                                          elevation: 0,
                                          margin: const EdgeInsets.only(bottom: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox.square(
                                                    dimension: 135,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: FadeInImage.assetNetwork(
                                                        placeholder: 'assets/images/IMAG.png',
                                                        image: activity.medias.firstWhere(
                                                          (m) => !m.startsWith('mp4'),
                                                          orElse: () => '',
                                                        ),
                                                        height: 150,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                activity.name,
                                                                maxLines: 2,
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: AppColors.primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                            if (_filterType == ReservationsFilterType.draft)
                                                              IconButton(
                                                                onPressed:
                                                                    () => getIt<ReservationsCubit>().removeReservation(
                                                                      reservation.id,
                                                                    ),
                                                                icon: Icon(Icons.delete),
                                                              ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          activity.address.formattedAddress,
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            color: AppColors.grayTextColor,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color: AppColors.secondTextColor,
                                                            ),
                                                            children: [
                                                              const TextSpan(
                                                                text: 'Date ',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14,
                                                                  color: AppColors.secondTextColor,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    activity.date.length < 10
                                                                        ? ''
                                                                        : activity.date.substring(0, 10),
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  color: AppColors.grayTextColor,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  getIt<ReservationsCubit>().setReservation(reservation);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ReservationScreen()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.primaryColor,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                  minimumSize: Size(double.infinity, 35),
                                                ),
                                                child: Text(context.l10n.viewReservationDetails),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  if (isLoadingMore)
                                    Center(
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      : SigninPlaceholder(onLoginSuccessfuly: _onLogin),
            ),
          ],
        );
      },
    ),
  );

  Widget buildTabButton({required String text, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String title, required String subtitle}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 75, color: AppColors.primaryColor),
          SizedBox(height: 16),
          Text(title, style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.poppins(color: AppColors.primaryColor.withAlpha(180), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
