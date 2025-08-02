import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------------------ Favorite Card Widget ------------------------

class FavoriteCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String guests;
  final String price;
  final VoidCallback? onTap;
  final bool showHeartIcon;

  const FavoriteCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.guests,
    required this.price,
    this.onTap,
        this.showHeartIcon = true,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageUrl,
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
                        title,
                        style: const TextStyle(
                          color: AppColors.secondTextColor,
                          height: 0.9,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      color: AppColors.grayTextColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    guests,
                    style: const TextStyle(
                      height: 0.9,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.grayTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          height: 0.9,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.primaryColor,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (showHeartIcon)
            Positioned(
              top: 15,
              right: 15,
              child: GestureDetector(
                child: SvgPicture.asset(
                  ImageAssets.heartBlack,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ------------------------ Favorite Grid Widget ------------------------

class FavoriteGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteItems;
  final Function(int index)? onItemTap;

  const FavoriteGridWidget({
    super.key,
    required this.favoriteItems,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          mainAxisExtent: 290,
        ),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return FavoriteCardWidget(
            imageUrl: item['image'],
            title: item['title'],
            location: item['location'],
            guests: item['guests'],
            price: item['price'],
            onTap: onItemTap != null ? () => onItemTap!(index) : null,
          );
        },
      ),
    );
  }
}

// ------------------------ Favorite Header Widget ------------------------

class FavoriteHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showBackButton;

  const FavoriteHeaderWidget({
    super.key,
    required this.title,
    this.onTap,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        if (showBackButton)
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "favorite",
                style: TextStyle(
                  color: AppColors.grayTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              )
            ],
          ),
        if (showBackButton) const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 16,
          ),
          child: InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------ Empty Favorite Widget ------------------------

class EmptyFavoriteWidget extends StatelessWidget {
  final String iconAsset;
  final String message;

  const EmptyFavoriteWidget({
    super.key,
    this.iconAsset = ImageAssets.noItemInFavorite,
    this.message = "You don't have any Favorite\nproducts yet",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.only(bottom: 24),
            child: SvgPicture.asset(
              iconAsset,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondTextColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------ Empty Favorite Screen Content Widget ------------------------

class EmptyFavoriteScreenContent extends StatelessWidget {
  final VoidCallback? onTitleTap;
  final bool showBackButton;
  final String iconAsset;
  final String message;

  const EmptyFavoriteScreenContent({
    super.key,
    this.onTitleTap,
    this.showBackButton = true,
    this.iconAsset = ImageAssets.noItemInFavorite,
    this.message = "You don't have any Favorite\nproducts yet",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FavoriteHeaderWidget(
          title: 'Your favorite',
          onTap: onTitleTap,
          showBackButton: showBackButton,
        ),
        Expanded(
          child: EmptyFavoriteWidget(
            iconAsset: iconAsset,
            message: message,
          ),
        ),
      ],
    );
  }
}

// ------------------------ Favorite Screen Content Widget ------------------------

class FavoriteScreenContent extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteItems;
  final Function(int index)? onItemTap;
  final VoidCallback? onTitleTap;

  const FavoriteScreenContent({
    super.key,
    required this.favoriteItems,
    this.onItemTap,
    this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Your favorite',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: FavoriteGridWidget(
            favoriteItems: favoriteItems,
            onItemTap: onItemTap,
          ),
        ),
      ],
    );
  }
}

// ------------------------ Legacy Favorite Card Widget ------------------------

class FavoriteCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String guests;
  final String price;

  const FavoriteCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.guests,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: AppColors.grayTextColor),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
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
                      title,
                      style: const TextStyle(
                          color: AppColors.secondTextColor,
                          height: 0.9,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.primaryColor,
                          size: 10,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.5',
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style:
                      const TextStyle(color: AppColors.grayTextColor, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(guests,
                    style: const TextStyle(
                        height: 0.9,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.grayTextColor)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        height: 0.9,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.primaryColor,
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
                          color: AppColors.grayTextColor),
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
            onTap: () {},
            child: SvgPicture.asset(
              ImageAssets.heartBlack,
              width: 20,
              height: 20,
              //color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
