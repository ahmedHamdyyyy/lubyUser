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
import '../../../models/favorite.dart';
import '../../../models/property.dart';
import '../views/property_screen.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({super.key, required this.property});
  final CustomPropertyModel property;
  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  // late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    // _isFavorite = widget.property.isFavorite;
  }

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyScreen(id: widget.property.id)));
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
                    imageUrl: widget.property.image,
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
                              if (widget.property.isFavorite) {
                                getIt<FavoritesCubit>().removeFromFavorites(widget.property.id, FavoriteType.property);
                              } else {
                                getIt<FavoritesCubit>().addToFavorites(widget.property.id, FavoriteType.property);
                              }
                            },
                            icon: Icon(widget.property.isFavorite ? Icons.favorite : Icons.favorite_border, size: 24),
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
                          widget.property.type,
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
                        widget.property.rate.toString(),
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  Text(
                    widget.property.address,
                    style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${widget.property.guestNumber} ${context.l10n.guests}",
                    style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          context.l10n.fromSarPrice(widget.property.pricePerNight.toStringAsFixed(2)),
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
                        context.l10n.perNightLabel,
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
