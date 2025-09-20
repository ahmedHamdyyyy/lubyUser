// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../config/constants/constance.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../locator.dart';
import '../../activities/view/screens/activity.dart';
import '../../models/favorite.dart';
import '../../profile/screens/propreties/views/rental_details_view.dart';
import '../cubit/cubit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  late final AnimationController _emptyAnimationController;
  // late final Animation<double> _floatAnimation;
  @override
  void initState() {
    getIt.get<FavoritesCubit>().fetchFavorites();
    _handleFetchMoreItems();
    super.initState();
  }

  @override
  void dispose() {
    _emptyAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleFetchMoreItems() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        getIt.get<FavoritesCubit>().fetchFavorites(fetchNext: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Your favorite',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => getIt.get<FavoritesCubit>().fetchFavorites(),
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => setState(() => _isLoadingMore = state.getFavoritesStatus == Status.loading),
                  );
                  if (state.getFavoritesStatus == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.getFavoritesStatus == Status.error) {
                    return Center(
                      child: Text(
                        state.message.isNotEmpty ? state.message : 'Failed to load favorites',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (state.favorites.isEmpty) {
                    return Center(
                      child: Text('No favorites found', style: TextStyle(color: AppColors.grayTextColor, fontSize: 16)),
                    );
                  }
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                            mainAxisExtent: 280,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: state.favorites.length,
                          itemBuilder: (context, index) {
                            final item = state.favorites[index];
                            return InkWell(
                              onTap: () {
                                item.type == FavoriteType.property
                                    ? Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RentalDetailScreen(id: item.itemId)),
                                    )
                                    : Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ActivityScreen(id: item.itemId)),
                                    );
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/images/apartment_view.jpg',
                                              image: item.imageUrl,
                                              imageErrorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/apartment_view.jpg',
                                                  width: 159,
                                                  height: 159,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                              width: 159,
                                              height: 159,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.title,
                                                style: const TextStyle(
                                                  color: AppColors.secondTextColor,
                                                  height: 0.9,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star, color: AppColors.primaryColor, size: 10),
                                                  const SizedBox(width: 4),
                                                  Text('4.5', style: TextStyle(color: AppColors.primaryColor, fontSize: 14)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.address.formattedAddress,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(color: AppColors.grayTextColor, fontSize: 14),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${item.guests} guests',
                                            style: const TextStyle(
                                              height: 0.9,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.grayTextColor,
                                            ),
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${item.price} per night',
                                                  style: const TextStyle(
                                                    height: 0.9,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    overflow: TextOverflow.ellipsis,
                                                    color: AppColors.primaryColor,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                'Per night',
                                                style: TextStyle(
                                                  height: 0.9,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  overflow: TextOverflow.ellipsis,
                                                  color: AppColors.grayTextColor,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 15,
                                    right: 15,
                                    child: GestureDetector(
                                      onTap:
                                          () => getIt.get<FavoritesCubit>().removeFromFavorites(
                                            item.itemId,
                                            FavoriteType.property,
                                          ),
                                      child: SvgPicture.asset(ImageAssets.heartBlack, width: 20, height: 20),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        if (_isLoadingMore)
                          const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
