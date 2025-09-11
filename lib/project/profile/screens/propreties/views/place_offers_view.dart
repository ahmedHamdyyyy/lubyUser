import 'package:flutter/material.dart';

import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../models/activity.dart';
import '../widgets/amenities_widget.dart';
import 'rental_details_view.dart';

class PlaceOffersView extends StatelessWidget {
  final HomeState state;
  const PlaceOffersView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RentalDetailScreen(id: '')),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new, size: 24),
                  color: const Color(0xFF757575),
                ),
                const SizedBox(width: 8),
                const TextWidget(text: 'Studio', color: Color(0xFF757575), fontSize: 16, fontWeight: FontWeight.w400),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextWidget(
              text: 'What this place offers',
              color: Color(0xFF414141),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: List.generate(state.property.tags.length, (index) => TileItemList(state: state)),
            ),
          ),
        ],
      ),
    );
  }
}




class PlaceOffersViewActivity extends StatelessWidget {
  final ActivityModel state;
  const PlaceOffersViewActivity({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RentalDetailScreen(id: '')),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new, size: 24),
                  color: const Color(0xFF757575),
                ),
                const SizedBox(width: 8),
                TextWidget(text: state.name, color: Color(0xFF757575), fontSize: 16, fontWeight: FontWeight.w400),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextWidget(
              text: 'What this place offers',
              color: Color(0xFF414141),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: List.generate(state.tags.length, (index) => TileItemListActivity(state: state)),
            ),
          ),
        ],
      ),
    );
  }
}
