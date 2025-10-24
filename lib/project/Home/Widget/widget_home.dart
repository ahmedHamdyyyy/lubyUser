// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/core/localization/l10n_ext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/image_assets.dart';
import '../../../../locator.dart';
import '../../activities/cubit/cubit.dart';
import '../../activities/view/screens/activity.dart';
import '../../favorites/cubit/cubit.dart';
import '../../models/activity.dart';
import '../../models/favorite.dart';
import '../../models/property.dart';
import '../../profile/screens/Notifications/notifications_screen.dart';
import '../../profile/screens/account/account_info/account_screen.dart';
import '../../profile/screens/propreties/views/rental_details_view.dart';
import '../cubit/home_cubit.dart';
import 'select_citi_widget.dart';

class IconNotifcationHome extends StatefulWidget {
  const IconNotifcationHome({super.key});

  @override
  _IconNotifcationHome createState() => _IconNotifcationHome();
}

class _IconNotifcationHome extends State<IconNotifcationHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
        },
        child: SvgPicture.asset(ImageAssets.notificationsIcon, width: 30, height: 30),
      ),
    );
  }
}

class IconNotifcationVendor extends StatelessWidget {
  const IconNotifcationVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      child: GestureDetector(
        onTap: () {
          /*   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationsScreenVendor(),
              )); */
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor,
            shape: BoxShape.rectangle,
          ),
          child: SvgPicture.asset(ImageAssets.notificationsIcon, width: 30, height: 30),
        ),
      ),
    );
  }
}

Row iconImageTaxt(HomeState state, BuildContext context) {
  return Row(
    children: [
      GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen())),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child:
              state.user.profilePicture.isNotEmpty
                  ? Image.network(
                    state.user.profilePicture,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade300, Colors.blue.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.person, color: Colors.white, size: 28),
                      );
                    },
                  )
                  : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade300, Colors.blue.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 28),
                  ),
        ),
      ),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${state.user.firstName} ${state.user.lastName}",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            context.l10n.welcomeToOurApp,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Spacer(),
      IconNotifcationHome(),
    ],
  );
}

Widget buildBottomNavigationBar(BuildContext context, {int currentIndex = 0, Function(int)? onTap}) {
  return BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey.shade600,
    type: BottomNavigationBarType.fixed, // ثابت لعرض جميع العناصر
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedFontSize: 12,
    unselectedFontSize: 12,
    elevation: 8,
    currentIndex: currentIndex,
    onTap: onTap,
    items: [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageAssets.home,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          ImageAssets.home,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
        label: context.l10n.navHome,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageAssets.heart,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          ImageAssets.heart,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
        label: context.l10n.navFavorites,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageAssets.clipboardTick,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          ImageAssets.clipboardTick,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
        label: context.l10n.navBookings,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageAssets.messages,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          ImageAssets.messages,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
        label: context.l10n.navMessages,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageAssets.userIcon,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          ImageAssets.userIcon,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
        label: context.l10n.navProfile,
      ),
    ],
  );
}

Widget buildPickerList({required String title, required List<String> items, required Function(String) onSelect}) {
  return Container(
    height: 400,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  onSelect(items[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderItem(String imagePath, String text) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.asset(imagePath, fit: BoxFit.cover),
      Container(
        color: Colors.black.withOpacity(0.3), // تأثير شفاف فوق الصورة
      ),
      Positioned(
        left: 20,
        bottom: 50,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget buildImageSlider(BuildContext context, PageController pageController) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // لتدوير الزوايا
          child: SizedBox(
            height: 140, // Reduced from 160 to save more vertical space
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: [
                    buildSliderItem("assets/images/pageview.png", context.l10n.sliderBookApartmentNow),
                    buildSliderItem("assets/images/pageview.png", context.l10n.sliderFindDreamHome),
                    buildSliderItem("assets/images/pageview.png", context.l10n.sliderExperienceLuxury),
                  ],
                ),
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: AppColors.primaryColor,
                        dotColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 4), // Reduced from 8 to save space
    ],
  );
}

Widget buildPropertyList({
  required String title,
  required BuildContext context,
  required HomeState state,
  String? selectedPropertyCategory,
  required ValueChanged<Map<String, dynamic>> onApplyFilters,
}) {
  // String? selectedPropertyType, selectedPriceRange, selectedRatingRange;

  // // قائمة أنواع العقارات
  // final List<String> propertyTypes = [
  //   context.l10n.propertyTypeApartmentStudios,
  //   context.l10n.propertyTypeCamps,
  //   context.l10n.propertyTypeVillas,
  // ];

  // // قائمة نطاقات الأسعار
  // final List<String> priceRanges = [context.l10n.priceHighToLow, context.l10n.priceLowToHigh];

  // // قائمة نطاقات التقييم
  // final List<String> ratingRanges = [context.l10n.ratingHighToLow, context.l10n.ratingDefault];

  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row - more compact
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.secondTextColor),
              ),
              // InkWell(
              //   onTap: () {
              //     showFilterOptions(
              //       context,
              //       propertyTypes,
              //       priceRanges,
              //       ratingRanges,
              //       selectedPropertyType ?? '',
              //       selectedPriceRange ?? '',
              //       selectedRatingRange ?? '',
              //       onApply: (String sType, String sPrice, String sRating) {
              //         // Build backend-compatible sort filters
              //         final Map<String, dynamic> filters = {};

              //         // Price sort
              //         if (sPrice.isNotEmpty) {
              //           if (sPrice == context.l10n.priceHighToLow) {
              //             filters['sort[pricePerNight]'] = 'desc';
              //           } else if (sPrice == context.l10n.priceLowToHigh) {
              //             filters['sort[pricePerNight]'] = 'asc';
              //           }
              //         }

              //         // Rating sort
              //         if (sRating.isNotEmpty) {
              //           if (sRating == context.l10n.ratingHighToLow) {
              //             filters['sort[averageRating]'] = 'desc';
              //           } else if (sRating == context.l10n.ratingDefault) {
              //             // No sort for rating
              //           }
              //         }

              //         onApplyFilters(filters);
              //       },
              //     );
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(left: 10),
              //     decoration: BoxDecoration(
              //       color: AppColors.primaryColor,
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: AppColors.primaryColor),
              //     ),
              //     child: Image.asset('assets/images/setting-4.png', color: Colors.white, width: 30, height: 30),
              //   ),
              // ),
            ],
          ),
        ),

        state.properties.isEmpty
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    selectedPropertyCategory == null
                        ? context.l10n.noPropertiesFound
                        : context.l10n.noPropertiesFound.replaceFirst('properties', selectedPropertyCategory),
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
            : GridView.builder(
              itemCount: state.properties.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) => buildPropertyCard(context, state.properties[index]),
            ),
      ],
    ),
  );
}

Widget buildPropertyCard(BuildContext context, CustomPropertyModel property) {
  bool isFavorite = property.isFavorite;
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RentalDetailScreen(id: property.id)));
    },
    child: Card(
      color: Colors.white,
      elevation: 3, // Reduced elevation
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image with fixed aspect ratio and heart icon
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                FadeInImage.assetNetwork(
                  image: property.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/IMAG.png',
                  placeholderFit: BoxFit.cover,
                ),
                StatefulBuilder(
                  builder:
                      (context, setState) => IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            getIt<FavoritesCubit>().removeFromFavorites(property.id, FavoriteType.property);
                          } else {
                            getIt<FavoritesCubit>().addToFavorites(property.id, FavoriteType.property);
                          }
                          setState(() => isFavorite = !isFavorite);
                        },
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 24),
                      ),
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
                        property.type,
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
                      property.rate.toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primaryColor),
                    ),
                  ],
                ),
                Text(
                  property.address,
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${property.guestNumber} ${context.l10n.guests}",
                      style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            context.l10n.sarAmount(property.pricePerNight),
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget categoryButton(String text, String selected, Function(String) onTap, {bool isMain = true}) {
  bool isSelected = selected == text;

  return ElevatedButton(
    onPressed: () => onTap(text),
    style: ElevatedButton.styleFrom(
      minimumSize: Size(!isMain ? 73 : 160, !isMain ? 32 : 48),

      backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
      side: BorderSide(color: AppColors.primaryColor),
      //padding: EdgeInsets.symmetric(horizontal: 15),

      // Reduced padding to match regular category buttons
      padding: EdgeInsets.symmetric(horizontal: isMain ? 2 : 12, vertical: isMain ? 2 : 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Row(
      //mainAxisSize: MainAxisSize.min,
      children: [
        // Safely display SVG or fallback icon without try/catch
        const SizedBox(width: 3), // Reduced spacing
        Text(
          text,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : AppColors.primaryColor,
            // Reduced font size to match regular button
            fontSize: isMain ? 16 : 14,
            fontWeight: isSelected ? FontWeight.w400 : FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

/*  */
Widget buildRadioOption(String text, bool isSelected, Function(String) onSelect) {
  return InkWell(
    onTap: () => onSelect(text),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          isSelected
              ? SvgPicture.asset(ImageAssets.cracalBlack, width: 20, height: 20, color: AppColors.primaryColor)
              : SvgPicture.asset(
                ImageAssets.cracalWhite,
                width: 20,
                height: 20,
                //color: AppColors.,
              ),
          const SizedBox(width: 10),
          Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.grayTextColor)),
        ],
      ),
    ),
  );
}

void showFilterOptions(
  BuildContext context,
  List<String> propertyTypes,
  List<String> priceRanges,
  List<String> ratingRanges,
  String selectedPropertyType,
  String selectedPriceRange,
  String selectedRatingRange, {
  required void Function(String selectedPropertyType, String selectedPriceRange, String selectedRatingRange) onApply,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Title and Cancel button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.filterTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.secondTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          context.l10n.commonCancel,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      // Property Type section
                      /*    Text(
                        "Property Type",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.grayTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ), */
                      ...propertyTypes
                          .map(
                            (type) => buildRadioOption(type, type == selectedPropertyType, (value) {
                              setState(() {
                                selectedPropertyType = value;
                              });
                            }),
                          )
                          .toList(),

                      SizedBox(height: 16),

                      // Price section
                      Text(
                        context.l10n.priceLabel,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      ...priceRanges
                          .map(
                            (range) => buildRadioOption(range, range == selectedPriceRange, (value) {
                              setState(() {
                                selectedPriceRange = value;
                              });
                            }),
                          )
                          .toList(),

                      SizedBox(height: 16),

                      // Rate section
                      Text(
                        context.l10n.rateLabel,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.secondGrayTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      ...ratingRanges
                          .map(
                            (rate) => buildRadioOption(rate, rate == selectedRatingRange, (value) {
                              setState(() {
                                selectedRatingRange = value;
                              });
                            }),
                          )
                          .toList(),

                      SizedBox(height: 24),
                    ],
                  ),
                ),

                // Search button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        // Apply filters back to caller and close
                        onApply(selectedPropertyType, selectedPriceRange, selectedRatingRange);
                        Navigator.pop(context);
                      },
                      child: Text(context.l10n.commonSearch, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class HomeSearchSection extends StatefulWidget {
  const HomeSearchSection({super.key, required this.onSearch});
  final ValueChanged<Map<String, dynamic>> onSearch;
  @override
  State<HomeSearchSection> createState() => _HomeSearchSectionState();
}

class _HomeSearchSectionState extends State<HomeSearchSection> {
  String? selectedCity, selectedState;
  DateTime? checkInDate, checkOutDate;
  int guestsCount = 0;

  final cities = ['Riyadh', 'Jeddah', 'Dammam', 'Alula', 'Makkah', 'Jazan', 'Tabuk', 'Abha'];
  final district = ['East Riyadh', 'West Riyadh', 'North Riyadh', 'South Riyadh', 'Central Riyadh', 'Other'];

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CityDropdown(
          title: context.l10n.cityLabel,
          hint: context.l10n.cityLabel,
          list: cities,
          selectedCity: selectedCity,
          onChanged: (value) => selectedCity = value,
        ),
        SizedBox(height: 12),
        CityDropdown(
          title: context.l10n.districtOptionalLabel,
          hint: context.l10n.districtLabel,
          list: district,
          selectedCity: selectedState,
          onChanged: (value) => selectedState = value,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.checkIn.trim(),
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.secondTextColor),
                  ),
                  SizedBox(height: 6),
                  HomeInputBox(
                    text:
                        checkInDate != null
                            ? "${checkInDate!.day}/${checkInDate!.month}/${checkInDate!.year}"
                            : context.l10n.selectDateLabel,
                    onPressed: () => _selectDate(context, checkInDate, (date) => setState(() => checkInDate = date)),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.checkOut.trim(),
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.secondTextColor),
                  ),
                  SizedBox(height: 6),
                  HomeInputBox(
                    text:
                        checkOutDate != null
                            ? "${checkOutDate!.day}/${checkOutDate!.month}/${checkOutDate!.year}"
                            : context.l10n.selectDateLabel,
                    onPressed: () {
                      _selectDate(
                        context,
                        checkOutDate,
                        (date) => setState(() => checkOutDate = date),
                        checkInDate: checkInDate,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.guestsNoLabel,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.secondTextColor),
            ),
            SizedBox(height: 6),
            HomeGuestsSelector(guestsCount: guestsCount, onChanged: (guests) => guestsCount = guests),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  String? fmt(DateTime? d) => d?.toIso8601String().split('T').first;
                  widget.onSearch({
                    if (selectedCity != null) 'filter[city]': selectedCity,
                    if (selectedState != null) 'filter[state]': selectedState,
                    if (checkInDate != null) 'filter[startDate]': fmt(checkInDate),
                    if (checkOutDate != null) 'filter[endDate]': fmt(checkOutDate),
                    if (guestsCount > 0) 'filter[guestNumber]': guestsCount,
                  });
                },
                child: Text(
                  context.l10n.commonSearch,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                selectedCity = null;
                selectedState = null;
                checkInDate = null;
                checkOutDate = null;
                guestsCount = 0;
                setState(() {});
                widget.onSearch({});
              },
              child: Icon(Icons.filter_list_off, color: Colors.white),
            ),
          ],
        ),
      ],
    ),
  );

  Future<void> _selectDate(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime) onDateSelect, {
    DateTime? checkInDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      onDateSelect(pickedDate);
    }
  }
}

class HomeInputBox extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isCity;

  const HomeInputBox({super.key, required this.text, required this.onPressed, this.isCity = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor)),
          InkWell(
            focusColor: Colors.transparent,
            onTap: onPressed,
            child: Icon(Icons.keyboard_arrow_down, color: AppColors.grayColorIcon),
          ),
        ],
      ),
    );
  }
}

class HomeGuestsSelector extends StatefulWidget {
  const HomeGuestsSelector({super.key, required this.guestsCount, required this.onChanged});
  final int guestsCount;
  final ValueChanged<int> onChanged;
  @override
  State<HomeGuestsSelector> createState() => _HomeGuestsSelectorState();
}

class _HomeGuestsSelectorState extends State<HomeGuestsSelector> {
  late int guestsCount;
  @override
  void initState() {
    guestsCount = widget.guestsCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(border: Border.all(color: AppColors.lightGray), borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.guests,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
          ),
        ),
        IconButton(
          onPressed: () {
            if (guestsCount <= 0) return;
            setState(() => guestsCount--);
            widget.onChanged(guestsCount);
          },
          icon: SvgPicture.asset('assets/svg/message-minus.svg', width: 20, height: 20, color: AppColors.primaryColor),
        ),
        Text(
          "$guestsCount",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
        ),
        IconButton(
          onPressed: () {
            if (guestsCount >= 100) return;
            setState(() => guestsCount++);
            widget.onChanged(guestsCount);
          },
          icon: SvgPicture.asset('assets/svg/message-add.svg', width: 20, height: 20, color: AppColors.primaryColor),
        ),
      ],
    ),
  );
}

class HomeCategoryButtons extends StatelessWidget {
  final Function(String)? onCategoryChanged;
  final Function(String)? onMainCategoryChanged;

  const HomeCategoryButtons({super.key, this.onCategoryChanged, this.onMainCategoryChanged});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> selectedMainCategory = ValueNotifier<String>(context.l10n.rentalService);
    ValueNotifier<String> selectedSubCategory = ValueNotifier<String>(context.l10n.propertiesSection);

    return ValueListenableBuilder<String>(
      valueListenable: selectedMainCategory,
      builder: (context, mainCategory, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: categoryButton(context.l10n.rentalService, mainCategory, (value) {
                    selectedMainCategory.value = value;
                    if (onMainCategoryChanged != null) {
                      onMainCategoryChanged!(value);
                    }
                  }),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: categoryButton(context.l10n.touristActivities, mainCategory, (value) {
                      selectedMainCategory.value = value;

                      if (onMainCategoryChanged != null) {
                        onMainCategoryChanged!(value);
                      }
                      if (value == context.l10n.touristActivities) {
                        context.read<ActivitiesCubit>().getActivities();
                      }
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (mainCategory == context.l10n.rentalService)
              ValueListenableBuilder<String>(
                valueListenable: selectedSubCategory,
                builder: (context, subCategory, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      categoryButton(context.l10n.propertiesSection, subCategory, (value) {
                        selectedSubCategory.value = value;
                        if (onCategoryChanged != null) {
                          onCategoryChanged!(value);
                        }
                      }, isMain: false),
                      const SizedBox(width: 8),
                      categoryButton(context.l10n.categoryYacht, subCategory, (value) {
                        selectedSubCategory.value = value;
                        if (onCategoryChanged != null) {
                          onCategoryChanged!(value);
                        }
                      }, isMain: false),
                      const SizedBox(width: 8),
                      categoryButton(context.l10n.categoryCruise, subCategory, (value) {
                        selectedSubCategory.value = value;
                        if (onCategoryChanged != null) {
                          onCategoryChanged!(value);
                        }
                      }, isMain: false),
                    ],
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

Widget buildActivitiesList({
  required String title,
  required BuildContext context,
  required ActivitiesState state,
  ValueChanged<Map<String, dynamic>>? onApplyFilters,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.secondTextColor),
              ),
              if (onApplyFilters != null)
                InkWell(
                  onTap: () {
                    // Reuse bottom sheet to apply sorting on activities
                    showFilterOptions(
                      context,
                      const [], // no type radios for now
                      [context.l10n.priceHighToLow, context.l10n.priceLowToHigh],
                      [context.l10n.ratingHighToLow, context.l10n.ratingDefault],
                      '',
                      '',
                      '',
                      onApply: (String sType, String sPrice, String sRating) {
                        final Map<String, dynamic> filters = {};
                        // Activities price field is 'price'
                        if (sPrice.isNotEmpty) {
                          if (sPrice == context.l10n.priceHighToLow) {
                            filters['sort[price]'] = 'desc';
                          } else if (sPrice == context.l10n.priceLowToHigh) {
                            filters['sort[price]'] = 'asc';
                          }
                        }
                        if (sRating.isNotEmpty) {
                          if (sRating == context.l10n.ratingHighToLow) {
                            filters['sort[averageRating]'] = 'desc';
                          }
                        }
                        onApplyFilters(filters);
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Image.asset('assets/images/setting-4.png', color: Colors.white, width: 30, height: 30),
                  ),
                ),
            ],
          ),
        ),

        state.activities.isEmpty
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    context.l10n.noActivitiesFound,
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
            : GridView.builder(
              itemCount: state.activities.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return buildActivityCard(context, state.activities[index], index);
              },
            ),
      ],
    ),
  );
}

Widget buildActivityCard(BuildContext context, CustomActivityModel activity, int index) {
  bool isFavorite = activity.isFavorite;
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityScreen(id: activity.id)));
    },
    child: Card(
      color: Colors.white,
      elevation: 3,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image with fixed aspect ratio and heart icon
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                FadeInImage.assetNetwork(
                  image: activity.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/IMAG.png',
                  placeholderFit: BoxFit.cover,
                ),
                StatefulBuilder(
                  builder:
                      (context, setState) => IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            getIt<FavoritesCubit>().removeFromFavorites(activity.id, FavoriteType.activity);
                          } else {
                            getIt<FavoritesCubit>().addToFavorites(activity.id, FavoriteType.activity);
                          }
                          setState(() => isFavorite = !isFavorite);
                        },
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 24),
                      ),
                ),
              ],
            ),
          ),
          // Content
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

                // Activity type or location
                Text(
                  context.l10n.touristActivity,
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Duration and price
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.fullDayExperience,
                      style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            context.l10n.fromSarPrice('299'),
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
