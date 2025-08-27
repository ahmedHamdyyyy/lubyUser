// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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

Row iconImageTaxt(HomeState state) {
  return Row(
    children: [
      ClipRRect(
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
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${state.user.firstName} ${state.user.lastName}",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "Welcome to our App",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Spacer(),
      IconNotifcationHome(),
    ],
  );
}

Widget buildBottomNavigationBar({int currentIndex = 0, Function(int)? onTap}) {
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
        label: "Home",
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
        label: "Favorites",
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
        label: "Bookings",
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
        label: "Messages",
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
        label: "Profile",
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

Widget buildImageSlider(PageController pageController) {
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
                    buildSliderItem("assets/images/pageview.png", "BOOK YOUR\nAPARTMENT NOW"),
                    buildSliderItem("assets/images/pageview.png", "FIND YOUR DREAM HOME"),
                    buildSliderItem("assets/images/pageview.png", "EXPERIENCE LUXURY LIVING"),
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
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final cardWidth = (screenWidth - 48) / 2; // Calculate card width (subtracting padding and spacing)
  final cardHeight = cardWidth * 1.2; // Reduce aspect ratio from 1.3 to 1.2 to save vertical space

  String? selectedPropertyType;
  String? selectedPriceRange;
  String? selectedRatingRange;

  // قائمة أنواع العقارات
  final List<String> propertyTypes = ['Apartment - Studios', 'Camps', 'Villas'];

  // قائمة نطاقات الأسعار
  final List<String> priceRanges = ['From high to low', 'From low to high'];

  // قائمة نطاقات التقييم
  final List<String> ratingRanges = ['From high to low rated', 'default'];

  // Filter properties based on selected category
  List<PropertyModel> filteredProperties = state.properties;
  if (selectedPropertyCategory != null && selectedPropertyCategory != "Properties") {
    filteredProperties =
        state.properties.where((property) {
          return property.type.toLowerCase() == selectedPropertyCategory.toLowerCase();
        }).toList();
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row - more compact
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.secondTextColor),
              ),
              InkWell(
                onTap:
                    () => showFilterOptions(
                      context,
                      propertyTypes,
                      priceRanges,
                      ratingRanges,
                      selectedPropertyType ?? '',
                      selectedPriceRange ?? '',
                      selectedRatingRange ?? '',
                    ),
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

        SizedBox(
          height: cardHeight * 2.2 + 90, // Increased height for taller cards
          child:
              filteredProperties.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        SizedBox(height: 16),
                        Text(
                          "No ${selectedPropertyCategory ?? 'properties'} found",
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                  : GridView.builder(
                    itemCount: filteredProperties.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.7, // Increased aspect ratio for taller cards
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return buildPropertyCard(context, state, filteredProperties, index);
                    },
                  ),
        ),
      ],
    ),
  );
}

Widget buildPropertyCard(BuildContext context, HomeState state, List<PropertyModel> properties, int index) {
  bool isFavorite = properties[index].isFavorite;
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RentalDetailScreen(id: properties[index].id)));
    },
    child: Card(
      color: Colors.white,
      elevation: 0, // Reduced elevation
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image with fixed aspect ratio and heart icon
          Stack(
            children: [
              Image.network(height: 155, width: 155, properties[index].medias.first, fit: BoxFit.cover),
              Positioned(
                top: 10,
                right: 10,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          if (isFavorite) {
                            getIt<FavoritesCubit>().removeFromFavorites(properties[index].id, FavoriteType.property);
                          } else {
                            getIt<FavoritesCubit>().addToFavorites(properties[index].id, FavoriteType.property);
                          }
                          setState(() => isFavorite = !isFavorite);
                        },
                        child:
                            isFavorite
                                ? SvgPicture.asset(ImageAssets.heartBlack, fit: BoxFit.cover, width: 20, height: 20)
                                : SvgPicture.asset(ImageAssets.heart, fit: BoxFit.cover, width: 20, height: 20),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Content with minimal padding and layout
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        properties[index].type,
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
                      properties[index].rate.toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primaryColor),
                    ),
                  ],
                ),

                // Location with tiny font
                Text(
                  properties[index].address,
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Price and guests in one row
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${properties[index].guestNumber} Guests",
                      style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${properties[index].pricePerNight} SAR",
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
                          "Per Night",
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
  String selectedRatingRange,
) {
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
                        "Filter",
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
                          "Cancel",
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
                        "Price",
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
                        "Rate",
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
                        // تطبيق الفلتر والعودة للشاشة الرئيسية
                        Navigator.pop(context);

                        // طباعة الفلاتر التي تم اختيارها للتجربة
                        print('Filter :');
                        print('- Property Type: $selectedPropertyType');
                        print('- Price Range: $selectedPriceRange');
                        print('- Rating Range: $selectedRatingRange');
                      },
                      child: Text("Search", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
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

class HomeSearchSection extends StatelessWidget {
  final String? selectedCity;
  final String selectedDistrict;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int guestsCount;
  final VoidCallback onCitySelect;
  final VoidCallback onDistrictSelect;
  final Function(DateTime) onCheckInSelect;
  final Function(DateTime) onCheckOutSelect;
  final VoidCallback onGuestsIncrement;
  final VoidCallback onGuestsDecrement;
  final VoidCallback onSearch;

  final List<String> cities = ['Riyadh', 'Jeddah', 'Dammam', 'Alula', 'Makkah', 'Jazan', 'Tabuk', 'Abha'];

  final List<String> district = ['East Riyadh', 'West Riyadh', 'North Riyadh', 'South Riyadh', 'Central Riyadh', 'Other'];

  HomeSearchSection({
    super.key,
    required this.selectedCity,
    required this.selectedDistrict,
    this.checkInDate,
    this.checkOutDate,
    required this.guestsCount,
    required this.onCitySelect,
    required this.onDistrictSelect,
    required this.onCheckInSelect,
    required this.onCheckOutSelect,
    required this.onGuestsIncrement,
    required this.onGuestsDecrement,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CityDropdown(title: 'City', hint: 'City', list: cities),
          SizedBox(height: 12),
          CityDropdown(title: 'District (optional)', hint: 'District', list: district),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check in",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondTextColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    HomeInputBox(
                      text:
                          checkInDate != null
                              ? "${checkInDate!.day}/${checkInDate!.month}/${checkInDate!.year}"
                              : "Add dates",
                      onPressed: () => _selectDate(context, checkInDate, onCheckInSelect),
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
                      "Check out",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondTextColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    HomeInputBox(
                      text:
                          checkOutDate != null
                              ? "${checkOutDate!.day}/${checkOutDate!.month}/${checkOutDate!.year}"
                              : "Add dates",
                      onPressed:
                          () => _selectDate(
                            context,
                            checkOutDate,
                            onCheckOutSelect,
                            isCheckIn: false,
                            checkInDate: checkInDate,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Guests No.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Guests No.",
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.secondTextColor),
              ),
              SizedBox(height: 6),
              HomeGuestsSelector(guestsCount: guestsCount, onIncrement: onGuestsIncrement, onDecrement: onGuestsDecrement),
            ],
          ),

          SizedBox(height: 16),

          // Search button
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: onSearch,
              child: Text(
                "Search",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime) onDateSelect, {
    bool isCheckIn = true,
    DateTime? checkInDate,
  }) async {
    DateTime firstDate =
        isCheckIn
            ? DateTime.now()
            : (checkInDate != null ? checkInDate.add(Duration(days: 1)) : DateTime.now().add(Duration(days: 1)));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? firstDate,
      firstDate: firstDate,
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

class HomeGuestsSelector extends StatelessWidget {
  final int guestsCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const HomeGuestsSelector({super.key, required this.guestsCount, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: AppColors.lightGray), borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$guestsCount Guests",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
            ),
          ),
          IconButton(
            onPressed: guestsCount > 0 ? onDecrement : null,
            icon: SvgPicture.asset('assets/svg/message-minus.svg', width: 20, height: 20, color: AppColors.primaryColor),
          ),
          Text(
            "$guestsCount",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: SvgPicture.asset('assets/svg/message-add.svg', width: 20, height: 20, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

class HomeCategoryButtons extends StatelessWidget {
  final Function(String)? onCategoryChanged;
  final Function(String)? onMainCategoryChanged;

  const HomeCategoryButtons({super.key, this.onCategoryChanged, this.onMainCategoryChanged});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> selectedMainCategory = ValueNotifier<String>("Rental Services");
    ValueNotifier<String> selectedSubCategory = ValueNotifier<String>("Properties");

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
                  child: categoryButton("Rental Services", mainCategory, (value) {
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
                    child: categoryButton("Tourist Activities", mainCategory, (value) {
                      selectedMainCategory.value = value;

                      if (onMainCategoryChanged != null) {
                        onMainCategoryChanged!(value);
                      }
                      if (value == "Tourist Activities") {
                        context.read<ActivitiesCubit>().getActivities();
                      }
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (mainCategory == "Rental Services")
              ValueListenableBuilder<String>(
                valueListenable: selectedSubCategory,
                builder: (context, subCategory, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      categoryButton("Properties", subCategory, (value) {
                        selectedSubCategory.value = value;
                        if (onCategoryChanged != null) {
                          onCategoryChanged!(value);
                        }
                      }, isMain: false),
                      const SizedBox(width: 8),
                      categoryButton("Yacht", subCategory, (value) {
                        selectedSubCategory.value = value;
                        if (onCategoryChanged != null) {
                          onCategoryChanged!(value);
                        }
                      }, isMain: false),
                      const SizedBox(width: 8),
                      categoryButton("Cruise", subCategory, (value) {
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
  required ActivitiesState activitiesState,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final cardWidth = (screenWidth - 48) / 2;
  final cardHeight = cardWidth * 1.2;

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
            ],
          ),
        ),

        SizedBox(
          height: cardHeight * 2.2 + 90,
          child:
              activitiesState.activities.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        SizedBox(height: 16),
                        Text(
                          "No activities found",
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                  : GridView.builder(
                    itemCount: activitiesState.activities.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return buildActivityCard(context, activitiesState.activities, index);
                    },
                  ),
        ),
      ],
    ),
  );
}

Widget buildActivityCard(BuildContext context, List<CustomActivityModel> activities, int index) {
  bool isFavorite = activities[index].isFavorite;
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityScreen(id: activities[index].id)));
    },
    child: Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image with heart icon
          Stack(
            children: [
              Image.network(
                height: 155,
                width: 155,
                activities[index].image.isNotEmpty
                    ? activities[index].image
                    : 'https://via.placeholder.com/155x155?text=Activity',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 155,
                    width: 155,
                    color: Colors.grey[300],
                    child: Icon(Icons.local_activity, size: 50, color: Colors.grey[600]),
                  );
                },
              ),
              Positioned(
                top: 10,
                right: 10,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          if (isFavorite) {
                            getIt<FavoritesCubit>().removeFromFavorites(activities[index].id, FavoriteType.activity);
                          } else {
                            getIt<FavoritesCubit>().addToFavorites(activities[index].id, FavoriteType.activity);
                          }
                          setState(() => isFavorite = !isFavorite);
                        },
                        child:
                            isFavorite
                                ? SvgPicture.asset(ImageAssets.heartBlack, fit: BoxFit.cover, width: 20, height: 20)
                                : SvgPicture.asset(ImageAssets.heart, fit: BoxFit.cover, width: 20, height: 20),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        activities[index].name.isNotEmpty ? activities[index].name : "Activity",
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
                      activities[index].rate.toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primaryColor),
                    ),
                  ],
                ),

                // Activity type or location
                Text(
                  "Tourist Activity",
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
                      "Full Day Experience",
                      style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "From 299 SAR",
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
                          "Per Person",
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
