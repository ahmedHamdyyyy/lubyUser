import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luby2/project/models/favorite.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/images/assets.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../locator.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../Home/Widget/signin_placeholder.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../favorites/cubit/cubit.dart';
import '../../../screens/propreties/widgets/amenities_widget.dart';
import '../../../screens/propreties/widgets/host_details.dart';
import '../../../screens/propreties/widgets/medias_list.dart';
import '../../../screens/propreties/widgets/read_details_widget.dart';
import '../../../screens/propreties/widgets/read_more.dart';
import '../../../screens/propreties/widgets/reviews_widget.dart';
import '../../cubit/cubit.dart';
import '../widgets/booking_details.dart';
import '../widgets/reserve_card.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key, required this.id});
  final String id;
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool isExpanded = false;
  @override
  void initState() {
    getIt<ActivitiesCubit>().getActivity(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ActivitiesCubit, ActivitiesState>(
        builder: (context, state) {
          if (state.getActivityStatus == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.getActivityStatus == Status.error) {
            return Center(child: Text(state.msg));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Material(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(AssetsData.apartmentView), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackButton(),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/export.svg',
                                  // ignore: deprecated_member_use
                                  color: Colors.white, // Changes SVG color
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                BlocSelector<HomeCubit, HomeState, bool>(
                                  selector: (state) => state.isSignedIn,
                                  builder: (context, isSignedIn) {
                                    return InkWell(
                                      onTap: () async {
                                        if (!isSignedIn) {
                                          await showSigninPlaceholder(context);
                                          return;
                                        }
                                        if (state.activity.isFavorite) {
                                          getIt<FavoritesCubit>().removeFromFavorites(
                                            state.activity.id,
                                            FavoriteType.activity,
                                          );
                                        } else {
                                          getIt<FavoritesCubit>().addToFavorites(state.activity.id, FavoriteType.activity);
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/heart.svg',
                                        // ignore: deprecated_member_use
                                        color: Colors.white, // Changes SVG color
                                        height: 24,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Title
                    Positioned(
                      top: 100,
                      bottom: 0,
                      left: 23,
                      child: TextWidget(
                        text: state.activity.name.isNotEmpty ? state.activity.name : context.l10n.touristActivity,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 112),
                        ActivityCardeReserve(activity: state.activity),
                        const SizedBox(height: 10),
                        ActivityBookingDetailsWidget(activity: state.activity),
                        const Driver(),
                        TextWidget(
                          text: '${state.activity.details},',
                          color: Color(0xFF414141),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        TextWidget(
                          text: state.activity.address.formattedAddress,
                          color: Color(0xFF414141),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 10),
                        const Driver(),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/location.svg',
                              // ignore: deprecated_member_use
                              color: const Color(0xFF414141),
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.activity.address.formattedAddress,
                                style: TextStyle(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/map.svg',
                              // ignore: deprecated_member_use
                              color: AppColors.primaryColor,
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            TextWidget(
                              text: context.l10n.viewLocationOnMap,
                              color: Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        const Driver(),
                        ReviewsWidget(
                          entityId: state.activity.id,
                          review: state.activity.review,
                          isProperty: false,
                          commentsCount: state.activity.reviewsCount,
                          totalRate: state.activity.totalRate,
                        ),
                        HostDetailsWidget(vendor: state.activity.vendor),
                        MediasListWidget(medias: state.activity.medias),
                        const Driver(),
                        if (isExpanded == true)
                          ReadMoreTextWidget(details: state.activity.details)
                        else
                          ReadDetailsWidget(details: state.activity.details),
                        Center(
                          child: SizedBox(
                            width: 173,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF262626),
                                padding: const EdgeInsets.only(bottom: 2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: TextWidget(
                                text: isExpanded ? context.l10n.readLess : context.l10n.readMore,
                                color: const Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Driver(),
                        AmenitiesWidget(tags: state.activity.tags),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
