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
import '../../activities/view/widgets/activity_card.dart';
import '../../favorites/cubit/cubit.dart';
import '../../models/property.dart';
import '../../screens/propreties/widgets/property_card.dart';
import '../Widget/coming_soon_placeholder.dart';
import '../Widget/widget_home.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});
  @override
  _HomeScreenMainState createState() => _HomeScreenMainState();
}

enum MainCategory { rentalServices, touristActivities }

class _HomeScreenMainState extends State<HomeScreenMain> with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> _filters = {};
  final _scrollController = ScrollController();
  final _pageController = PageController();
  PropertyType? selectedPropertyCategory;
  MainCategory selectedMainCategory = MainCategory.rentalServices;

  String _localizedPropertyType(BuildContext context, PropertyType type) {
    switch (type) {
      case PropertyType.apartment:
        return context.l10n.apartmentsTitle;
      case PropertyType.studio:
        return context.l10n.propertyTypeApartmentStudios;
      case PropertyType.house:
        return context.l10n.villasTitle;
    }
  }

  @override
  void initState() {
    getIt<HomeCubit>().getProperties();
    getIt<HomeCubit>().loadNotifications();
    _handleFetchModeItems();
    // Precache static images to avoid first-paint jank
    WidgetsBinding.instance.addPostFrameCallback((_) => _precacheImages());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

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

  List<PropertyType> get _availablePropertyTypes => [PropertyType.apartment, PropertyType.studio, PropertyType.house];

  void _precacheImages() {
    final ctx = context;
    precacheImage(const AssetImage('assets/images/image5.png'), ctx);
    precacheImage(const AssetImage('assets/images/pageview.png'), ctx);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) => prev.user != next.user || prev.unreadNotificationsCount != next.unreadNotificationsCount,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () async {
              if (selectedMainCategory == MainCategory.rentalServices) {
                getIt<HomeCubit>().getProperties(filters: _filters);
              } else {
                getIt<ActivitiesCubit>().getActivities(filters: _filters);
              }
            },
            child: BlocListener<FavoritesCubit, FavoritesState>(
              listener: (context, favState) {
                if (favState.toggleFavoriteStatus == Status.loading) {
                  // Utils.loadingDialog(context);
                } else if (favState.toggleFavoriteStatus == Status.success) {
                  final favoriteCubit = getIt<FavoritesCubit>();
                  if (favoriteCubit.isProperty) {
                    getIt<HomeCubit>().toggleFavorite(favoriteCubit.itemId);
                  } else {
                    getIt<ActivitiesCubit>().toggleFavorite(favoriteCubit.itemId);
                  }
                } else if (favState.toggleFavoriteStatus == Status.error) {
                  showToast(text: favState.message, stute: ToustStute.error);
                }
              },
              child: CustomScrollView(
                key: const PageStorageKey('home_main_scroll'),
                controller: _scrollController,
                slivers: [
                  // Header banner with overlay
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 250),
                            decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/images/image5.png'), fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Positioned(top: 40, left: 20, right: 20, child: iconImageTaxt(state, context)),
                        Positioned(
                          top: 110,
                          left: 20,
                          right: 20,
                          child: HomeSearchSection(
                            onSearch: (filters) {
                              _filters = filters;
                              if (selectedMainCategory == MainCategory.rentalServices) {
                                getIt<HomeCubit>().getProperties(filters: _filters);
                              } else {
                                getIt<ActivitiesCubit>().getActivities(filters: _filters);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search, slider, and category buttons
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          buildImageSlider(context, _pageController),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 2, left: 16, right: 16),
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
                              child: Row(
                                children:
                                    _availablePropertyTypes
                                        .map(
                                          (type) => Expanded(
                                            child: Padding(
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
                                                      selectedPropertyCategory == type
                                                          ? AppColors.primaryColor
                                                          : Colors.white,
                                                  foregroundColor:
                                                      selectedPropertyCategory == type
                                                          ? Colors.white
                                                          : AppColors.primaryColor,
                                                  side: BorderSide(color: AppColors.primaryColor),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  padding: EdgeInsets.zero,
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment: Alignment.center,
                                                  child: Text(_localizedPropertyType(context, type)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Content slivers
                  if (selectedMainCategory == MainCategory.rentalServices) ...[
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, homeState) {
                        if (homeState.propertiesStatus == Status.loading && homeState.properties.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(height: 350, child: Center(child: CircularProgressIndicator())),
                          );
                        }
                        if (homeState.properties.isEmpty) {
                          return SliverToBoxAdapter(child: ComingSoonPlaceholder());
                        }
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.6,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            delegate: SliverChildBuilderDelegate((context, index) {
                              return RepaintBoundary(
                                key: ValueKey(homeState.properties[index].id),
                                child: PropertyCard(property: homeState.properties[index]),
                              );
                            }, childCount: homeState.properties.length),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, homeState) {
                        if (homeState.propertiesStatus == Status.loading && homeState.properties.isNotEmpty) {
                          return const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Center(
                                child: SizedBox(height: 28, width: 28, child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                            ),
                          );
                        }
                        return const SliverToBoxAdapter(child: SizedBox.shrink());
                      },
                    ),
                  ] else ...[
                    BlocBuilder<ActivitiesCubit, ActivitiesState>(
                      builder: (context, actState) {
                        if (actState.getAllActivitiesStatus == Status.loading && actState.activities.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(height: 350, child: Center(child: CircularProgressIndicator())),
                          );
                        }
                        if (actState.activities.isEmpty) {
                          return SliverToBoxAdapter(child: ComingSoonPlaceholder());
                        }
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.6,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => RepaintBoundary(
                                key: ValueKey(actState.activities[index].id),
                                child: ActivityCard(activity: actState.activities[index]),
                              ),
                              childCount: actState.activities.length,
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<ActivitiesCubit, ActivitiesState>(
                      builder: (context, actState) {
                        if (actState.getAllActivitiesStatus == Status.loading && actState.activities.isNotEmpty) {
                          return const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Center(
                                child: SizedBox(height: 28, width: 28, child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                            ),
                          );
                        }
                        return const SliverToBoxAdapter(child: SizedBox.shrink());
                      },
                    ),
                  ],

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
