import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../config/colors/colors.dart';
import '../../../../locator.dart';
import '../../../Home/Widget/signin_placeholder.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../favorites/cubit/cubit.dart';
import '../../../models/activity.dart';
import '../../../models/favorite.dart';
import '../screens/activity.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activity});
  final CustomActivityModel activity;
  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityScreen(id: activity.id)));
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CachedNetworkImage(
                    imageUrl: activity.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    memCacheWidth: 600,
                    filterQuality: FilterQuality.low,
                    fadeInDuration: const Duration(milliseconds: 150),
                    fadeOutDuration: const Duration(milliseconds: 150),
                    placeholder:
                        (context, url) => Image.asset(
                          'assets/images/IMAG.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          'assets/images/IMAG.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  ),
                  BlocSelector<HomeCubit, HomeState, bool>(
                    selector: (state) => state.isSignedIn,
                    builder: (context, isSignedIn) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return IconButton(
                            onPressed: () async {
                              if (!isSignedIn) {
                                await showSigninPlaceholder(context);
                                return;
                              }
                              if (activity.isFavorite) {
                                getIt<FavoritesCubit>().removeFromFavorites(activity.id, FavoriteType.activity);
                              } else {
                                getIt<FavoritesCubit>().addToFavorites(activity.id, FavoriteType.activity);
                              }
                            },
                            icon: Icon(activity.isFavorite ? Icons.favorite : Icons.favorite_border, size: 24),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activity.name.isNotEmpty ? activity.name : "Activity",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.star, color: AppColors.primaryColor, size: 14),
                      SizedBox(width: 1),
                      Text(
                        activity.rate.toString(),
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        activity.address,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.grayTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.l10n.fromSarPrice(activity.price.toInt()),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        context.l10n.perPersonLabel,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grayTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
