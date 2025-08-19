// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/locator.dart';
import 'package:luby2/project/user/Home/cubit/home_cubit.dart';

import '../../../../config/colors/colors.dart';
import '../../activities/cubit/cubit.dart';
import '../Widget/widget_home.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});

  @override
  _HomeScreenMainState createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  final _pageController = PageController();
  String selectedPropertyCategory = "Properties", selectedMainCategory = "Rental Services";

  final saudiCities = <String>['Riyadh', 'Jeddah', 'Dammam', 'Alula', 'Makkah', 'mohamed', 'Tabuk', 'Jazan'];

  String selectedCity = 'city', selectedDistrict = 'District';
  DateTime? checkInDate, checkOutDate;
  int guestsCount = 0;

  // Filter variables
  String? selectedPropertyType, selectedPriceRange, selectedRatingRange;

  // Property types list
  final propertyTypes = <String>['Apartment - Studios', 'Camps', 'Villas'];

  // Price ranges list
  final priceRanges = <String>['From high to low', 'From low to high'];

  // Rating ranges list
  final ratingRanges = <String>['From high to low rated', 'default'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              getIt<HomeCubit>().getProperties();
              getIt<ActivitiesCubit>().getActivities();
            },
            child: SingleChildScrollView(
              child: Column(
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
                            image: DecorationImage(image: AssetImage('assets/images/image5.png'), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(top: 40, left: 20, right: 20, child: iconImageTaxt(state)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 112),
                            HomeSearchSection(
                              selectedCity: selectedCity,
                              selectedDistrict: selectedDistrict,
                              checkInDate: checkInDate,
                              checkOutDate: checkOutDate,
                              guestsCount: guestsCount,
                              onCitySelect: () => showCityDropdown(context),
                              onDistrictSelect: () {},
                              onCheckInSelect: (date) {
                                if (checkOutDate != null && checkOutDate!.isBefore(date)) checkOutDate = null;
                                setState(() => checkInDate = date);
                              },
                              onCheckOutSelect: (date) => setState(() => checkOutDate = date),
                              onGuestsIncrement: () => setState(() => guestsCount++),
                              onGuestsDecrement: () => setState(() => guestsCount > 0 ? guestsCount-- : guestsCount),
                              onSearch: () {},
                            ),
                            const SizedBox(height: 16),
                            buildImageSlider(_pageController),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (selectedMainCategory != "Rental Services") {
                                          setState(() => selectedMainCategory = "Rental Services");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            selectedMainCategory == "Rental Services"
                                                ? AppColors.primaryColor
                                                : Colors.white,
                                        foregroundColor:
                                            selectedMainCategory == "Rental Services"
                                                ? Colors.white
                                                : AppColors.primaryColor,
                                        side: BorderSide(color: AppColors.primaryColor),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: Text('Rental Service'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (selectedMainCategory != "Tourist Activities") {
                                          setState(() => selectedMainCategory = "Tourist Activities");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            selectedMainCategory == "Tourist Activities"
                                                ? AppColors.primaryColor
                                                : Colors.white,
                                        foregroundColor:
                                            selectedMainCategory == "Tourist Activities"
                                                ? Colors.white
                                                : AppColors.primaryColor,
                                        side: BorderSide(color: AppColors.primaryColor),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: Text('Tourist Activities'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (selectedMainCategory == "Rental Services")
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (selectedPropertyCategory != "Properties") {
                                            setState(() => selectedPropertyCategory = "Properties");
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              selectedPropertyCategory == "Properties"
                                                  ? AppColors.primaryColor
                                                  : Colors.white,
                                          foregroundColor:
                                              selectedPropertyCategory == "Properties"
                                                  ? Colors.white
                                                  : AppColors.primaryColor,
                                          side: BorderSide(color: AppColors.primaryColor),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Text('Properties'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (selectedPropertyCategory != "Yacht") {
                                            setState(() => selectedPropertyCategory = "Yacht");
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              selectedPropertyCategory == "Yacht" ? AppColors.primaryColor : Colors.white,
                                          foregroundColor:
                                              selectedPropertyCategory == "Yacht" ? Colors.white : AppColors.primaryColor,
                                          side: BorderSide(color: AppColors.primaryColor),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Text('Yacht'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (selectedPropertyCategory != "Cruise") {
                                            setState(() => selectedPropertyCategory = "Cruise");
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              selectedPropertyCategory == "Cruise" ? AppColors.primaryColor : Colors.white,
                                          foregroundColor:
                                              selectedPropertyCategory == "Cruise" ? Colors.white : AppColors.primaryColor,
                                          side: BorderSide(color: AppColors.primaryColor),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Text('Cruise'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // HomeCategoryButtons(
                            //   onCategoryChanged: (category) => setState(() => selectedPropertyCategory = category),
                            //   onMainCategoryChanged: (mainCategory) => setState(() => selectedMainCategory = mainCategory),
                            // ),
                            const SizedBox(height: 16),
                            if (selectedMainCategory == "Rental Services")
                              Column(
                                children: [
                                  buildPropertyList(
                                    title: "Top Rated",
                                    context: context,
                                    state: state,
                                    selectedPropertyCategory: selectedPropertyCategory,
                                  ),
                                  const SizedBox(height: 16),
                                  buildPropertyList(
                                    title: "Most Viewed",
                                    context: context,
                                    state: state,
                                    selectedPropertyCategory: selectedPropertyCategory,
                                  ),
                                ],
                              )
                            else if (selectedMainCategory == "Tourist Activities")
                              BlocBuilder<ActivitiesCubit, ActivitiesState>(
                                builder: (context, activitiesState) {
                                  return Column(
                                    children: [
                                      buildActivitiesList(
                                        title: "Popular Activities",
                                        context: context,
                                        activitiesState: activitiesState,
                                      ),
                                      const SizedBox(height: 16),
                                      buildActivitiesList(
                                        title: "Recommended Activities",
                                        context: context,
                                        activitiesState: activitiesState,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showCityDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select City",
                style: GoogleFonts.poppins(color: AppColors.primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: saudiCities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(saudiCities[index], style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400)),
                      onTap: () {
                        setState(() {
                          selectedCity = saudiCities[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
