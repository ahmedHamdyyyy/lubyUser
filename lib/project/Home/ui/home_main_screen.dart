// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';
import 'package:luby2/locator.dart';
import 'package:luby2/project/Home/cubit/home_cubit.dart';

import '../../../../config/colors/colors.dart';
import '../../../config/constants/constance.dart';
import '../../../config/widget/widget.dart';
import '../../activities/cubit/cubit.dart';
import '../../favorites/cubit/cubit.dart';
import '../../models/property.dart';
import '../Widget/widget_home.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});
  @override
  _HomeScreenMainState createState() => _HomeScreenMainState();
}

enum MainCategory { rentalServices, touristActivities }

class _HomeScreenMainState extends State<HomeScreenMain> {
  Map<String, dynamic> _filters = {};
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  final _pageController = PageController();
  PropertyType? selectedPropertyCategory;
  MainCategory selectedMainCategory = MainCategory.rentalServices;

  String _localizedPropertyType(BuildContext context, PropertyType type) {
    // Prefer specific localization keys when available; otherwise, provide a sensible fallback.
    switch (type) {
      case PropertyType.apartment:
        // Apartments plural used as a category title
        return context.l10n.apartmentsTitle;
      case PropertyType.studio:
        // Group key that mentions Apartment - Studios
        return context.l10n.propertyTypeApartmentStudios;
      case PropertyType.cabin:
        return context.l10n.cabinsTitle;
      case PropertyType.house:
        // Approximate with villas if dedicated key is not available
        return context.l10n.villasTitle;
      case PropertyType.guest_house:
        // Missing explicit key in l10n; fallback to a readable label for now
        return context.l10n.propertiesSection;
      case PropertyType.yacht:
        return context.l10n.categoryYacht;
      case PropertyType.cruise:
        return context.l10n.categoryCruise;
    }
  }

  @override
  void initState() {
    getIt<HomeCubit>().getProperties();
    _handleFetchModeItems();
    super.initState();
  }

  void _handleFetchModeItems() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (selectedMainCategory == MainCategory.touristActivities) {
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _isLoadingMore = state.propertiesStatus == Status.loading);
      });
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            if (selectedMainCategory == MainCategory.rentalServices) {
              getIt<HomeCubit>().getProperties(filters: _filters);
            } else {
              getIt<ActivitiesCubit>().getActivities(filters: _filters);
            }
          },
          child: BlocListener<FavoritesCubit, FavoritesState>(
            listener: (context, state) {
              if (state.addToFavoritesStatus == Status.loading) {
                // Utils.loadingDialog(context);
              } else if (state.addToFavoritesStatus == Status.success) {
                // Navigator.of(context).pop();
                final favoriteCubit = getIt<FavoritesCubit>();
                if (favoriteCubit.isProperty) {
                  getIt<HomeCubit>().toggleFavorite(favoriteCubit.itemId);
                } else {
                  getIt<ActivitiesCubit>().toggleFavorite(favoriteCubit.itemId);
                }
              } else if (state.addToFavoritesStatus == Status.error) {
                // Navigator.of(context).pop();
                showToast(text: state.message, stute: ToustStute.error);
              }
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Stack(
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
                  Positioned(top: 40, left: 20, right: 20, child: iconImageTaxt(state, context)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 112),
                        HomeSearchSection(
                          onSearch: (filters) {
                            _filters = filters;
                            if (selectedMainCategory == MainCategory.rentalServices) {
                              getIt<HomeCubit>().getProperties(filters: _filters);
                            } else {
                              getIt<ActivitiesCubit>().getActivities(filters: _filters);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        buildImageSlider(context, _pageController),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (selectedMainCategory == MainCategory.rentalServices) {
                                      if (selectedPropertyCategory != null) {
                                        _filters.remove('filter[type]');
                                        setState(() => selectedPropertyCategory = null);
                                        getIt<HomeCubit>().getProperties(filters: _filters);
                                      }
                                    } else {
                                      selectedPropertyCategory = null;
                                      setState(() => selectedMainCategory = MainCategory.rentalServices);
                                      getIt<HomeCubit>().getProperties(filters: _filters);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        selectedMainCategory == MainCategory.rentalServices
                                            ? AppColors.primaryColor
                                            : Colors.white,
                                    foregroundColor:
                                        selectedMainCategory == MainCategory.rentalServices
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                    side: BorderSide(color: AppColors.primaryColor),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text(context.l10n.rentalService),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (selectedMainCategory == MainCategory.touristActivities) return;
                                    setState(() => selectedMainCategory = MainCategory.touristActivities);
                                    _filters.remove('filter[type]');
                                    getIt<ActivitiesCubit>().getActivities(filters: _filters);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        selectedMainCategory == MainCategory.touristActivities
                                            ? AppColors.primaryColor
                                            : Colors.white,
                                    foregroundColor:
                                        selectedMainCategory == MainCategory.touristActivities
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                    side: BorderSide(color: AppColors.primaryColor),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text(context.l10n.touristActivities),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selectedMainCategory == MainCategory.rentalServices)
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
                                          child: Text(_localizedPropertyType(context, type)),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        if (selectedMainCategory == MainCategory.rentalServices)
                          buildPropertyList(
                            title: context.l10n.mostViewed,
                            context: context,
                            state: state,
                            onApplyFilters: (newFilters) {
                              // Clear previous sort params before applying new ones
                              _filters.removeWhere((key, value) => key.startsWith('sort['));
                              _filters = {..._filters, ...newFilters};
                              getIt<HomeCubit>().getProperties(filters: _filters);
                            },
                          )
                        else if (selectedMainCategory == MainCategory.touristActivities)
                          BlocBuilder<ActivitiesCubit, ActivitiesState>(
                            builder: (context, state) {
                              return buildActivitiesList(
                                title: '',
                                context: context,
                                state: state,
                                onApplyFilters: (newFilters) {
                                  _filters.removeWhere((key, value) => key.startsWith('sort['));
                                  _filters = {..._filters, ...newFilters};
                                  getIt<ActivitiesCubit>().getActivities(filters: _filters);
                                },
                              );
                            },
                          ),
                        const SizedBox(height: 16),
                        if (_isLoadingMore)
                          const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
