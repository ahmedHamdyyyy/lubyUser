// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/locator.dart';
import 'package:luby2/project/user/Home/cubit/home_cubit.dart';
import 'package:luby2/project/user/activities/cubit/cubit.dart';

import '../../../../config/colors/colors.dart';
import '../Widget/widget_home.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});

  @override
  _HomeScreenMainState createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  final PageController _pageController = PageController();

  final List<String> saudiCities = ['Riyadh', 'Jeddah', 'Dammam', 'Alula', 'Makkah', 'mohamed', 'Tabuk', 'Jazan'];

  String? selectedCity;
  String selectedDistrict = 'District';
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guestsCount = 0;

  // Filter variables
  String? selectedPropertyType;
  String? selectedPriceRange;
  String? selectedRatingRange;

  // Property types list
  final List<String> propertyTypes = ['Apartment - Studios', 'Camps', 'Villas'];

  // Price ranges list
  final List<String> priceRanges = ['From high to low', 'From low to high'];

  // Rating ranges list
  final List<String> ratingRanges = ['From high to low rated', 'default'];

  @override
  void initState() {
    super.initState();
    selectedCity = 'city';

    getIt<HomeCubit>().getProperties();
    getIt<ActivitiesCubit>().getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider.value(value: getIt<ActivitiesCubit>()),
      ],

      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                getIt<HomeCubit>().getProperties();
              },
              child: HomeScreenMainContent(
                state: state,
                pageController: _pageController,
                selectedCity: selectedCity,
                selectedDistrict: selectedDistrict,
                checkInDate: checkInDate,
                checkOutDate: checkOutDate,
                guestsCount: guestsCount,
                onCitySelect: () {
                  showCityDropdown(context);
                },
                onDistrictSelect: () {},
                onCheckInSelect: (date) {
                  setState(() {
                    checkInDate = date;
                    // Reset checkout date if it's before check-in
                    if (checkOutDate != null && checkOutDate!.isBefore(checkInDate!)) {
                      checkOutDate = null;
                    }
                  });
                },
                onCheckOutSelect: (date) {
                  setState(() {
                    checkOutDate = date;
                  });
                },
                onGuestsIncrement: () {
                  setState(() {
                    guestsCount++;
                    print(guestsCount);
                  });
                },
                onGuestsDecrement: () {
                  if (guestsCount > 0) {
                    setState(() {
                      guestsCount--;
                      print(guestsCount);
                    });
                  }
                },
                onSearch: () {},
              ),
            ),
          );
        },
      ),
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
