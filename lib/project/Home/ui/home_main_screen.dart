// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/locator.dart';
import 'package:luby2/project/Home/cubit/home_cubit.dart';

import '../../../../config/colors/colors.dart';
import '../../activities/cubit/cubit.dart';
import '../../models/property.dart';
import '../Widget/widget_home.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});
  @override
  _HomeScreenMainState createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  Map<String, dynamic> _filters = {};
  final _scrollController = ScrollController();
  final _pageController = PageController();
  PropertyType? selectedPropertyCategory;
  String selectedMainCategory = "Rental Services";

  @override
  void initState() {
    getIt<HomeCubit>().getProperties();
    _handleFetchModeItems();
    super.initState();
  }

  void _handleFetchModeItems() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (selectedMainCategory == "Activities") {
          getIt<ActivitiesCubit>().getActivities(fetchNext: true, filters: _filters);
        } else {
          getIt<HomeCubit>().getProperties(fetchNext: true, filters: _filters);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            if (selectedMainCategory == "Rental Services") {
              getIt<HomeCubit>().getProperties(filters: _filters);
            } else {
              getIt<ActivitiesCubit>().getActivities(filters: _filters);
            }
          },
          child: SingleChildScrollView(
            controller: _scrollController,
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
                            onSearch: (filters) {
                              _filters = filters;
                              if (selectedMainCategory == "Rental Services") {
                                getIt<HomeCubit>().getProperties(filters: _filters);
                              } else {
                                getIt<ActivitiesCubit>().getActivities(filters: _filters);
                              }
                            },
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
                                      if (selectedMainCategory == "Rental Services") {
                                        if (selectedPropertyCategory != null) {
                                          _filters.remove('filter[type]');
                                          setState(() => selectedPropertyCategory = null);
                                          getIt<HomeCubit>().getProperties(filters: _filters);
                                        }
                                      } else {
                                        selectedPropertyCategory = null;
                                        setState(() => selectedMainCategory = "Rental Services");
                                        getIt<HomeCubit>().getProperties(filters: _filters);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          selectedMainCategory == "Rental Services" ? AppColors.primaryColor : Colors.white,
                                      foregroundColor:
                                          selectedMainCategory == "Rental Services" ? Colors.white : AppColors.primaryColor,
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
                                      if (selectedMainCategory == "Tourist Activities") return;
                                      setState(() => selectedMainCategory = "Tourist Activities");
                                      _filters.remove('filter[type]');
                                      getIt<ActivitiesCubit>().getActivities(filters: _filters);
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      PropertyType.values.map((type) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (selectedPropertyCategory == type) return;
                                              setState(() => selectedPropertyCategory = type);
                                              _filters['filter[type]'] = type.name;
                                              getIt<HomeCubit>().getProperties(filters: _filters);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  selectedPropertyCategory == type ? AppColors.primaryColor : Colors.white,
                                              foregroundColor:
                                                  selectedPropertyCategory == type ? Colors.white : AppColors.primaryColor,
                                              side: BorderSide(color: AppColors.primaryColor),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: Text(type.name.toUpperCase()),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                          if (selectedMainCategory == "Rental Services")
                            buildPropertyList(title: '', context: context, state: state)
                          else if (selectedMainCategory == "Tourist Activities")
                            BlocBuilder<ActivitiesCubit, ActivitiesState>(
                              builder: (context, state) {
                                return buildActivitiesList(title: '', context: context, state: state);
                                // return Column(
                                //   children: [
                                //     buildActivitiesList(title: "Popular Activities", context: context, state: state),
                                //     const SizedBox(height: 16),
                                //     buildActivitiesList(title: "Recommended Activities", context: context, state: state),
                                //   ],
                                // );
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
