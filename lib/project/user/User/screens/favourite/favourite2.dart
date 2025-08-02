// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import 'widget_favourite.dart';
import '../../../../../../config/widget/helper.dart';

class Favorite2Screen extends StatefulWidget {
  const Favorite2Screen({super.key});

  @override
  State<Favorite2Screen> createState() => _Favorite2ScreenState();
}

class _Favorite2ScreenState extends State<Favorite2Screen> {
  // Sample data for favorite items
  List<Map<String, dynamic>> favoriteItems = [
    {
      'image': "assets/images/image6.png",
      'title': 'Golden Hotel',
      'location': 'West jakarta',
      'guests': '1 bedroom - 1 bathroom - 100 m',
      'price': '\$143',
    },
    {
      'image': "assets/images/IMAG.png",
      'title': 'Queen Hotel',
      'location': 'West jakarta',
      'guests': '1 bedroom - 1 bathroom - 100 m',
      'price': '\$143',
    },
    {
      'image': "assets/images/image4.jpg",
      'title': 'Comfort Inn',
      'location': 'East jakarta',
      'guests': '2 bedroom - 1 bathroom - 120 m',
      'price': '\$165',
    },
    {
      'image': "assets/images/image5.jpg",
      'title': 'Luxury Plaza',
      'location': 'South jakarta',
      'guests': '1 bedroom - 1 bathroom - 95 m',
      'price': '\$120',
    }, {
      'image': "assets/images/image5.jpg",
      'title': 'Luxury Plaza',
      'location': 'South jakarta',
      'guests': '1 bedroom - 1 bathroom - 95 m',
      'price': '\$120',
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, "Favorite", AppColors.primaryTextColor),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FavoriteScreenContent(
          favoriteItems: favoriteItems,
          onItemTap: (index) {},
        ),
      ),
    );
  }
}
