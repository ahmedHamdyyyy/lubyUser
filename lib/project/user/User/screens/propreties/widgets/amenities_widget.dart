import 'package:flutter/material.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../views/place_offers_view.dart';
import 'list_tile_item.dart';

class AmenitiesWidget extends StatelessWidget {
  final HomeState state;
  const AmenitiesWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            text: 'What this place offers',

            color: Color(0xFF414141),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 16),
          TileItemList(state: state),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 240,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlaceOffersView(state: state)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262626),
                    elevation: 0,
                    padding: const EdgeInsets.only(bottom: 2),
                      shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const TextWidget(
                    text: 'Show All 24 Amenities',
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TileItemList extends StatelessWidget {
  final HomeState state;
  const TileItemList({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final tags = state.property.tags;
    return  Column(
      children: [
        (tags.isNotEmpty && tags[0].isNotEmpty) ? ListTileItem(
          icon: 'assets/images/waterfront.svg',
          text: tags[0],
        ) : const SizedBox.shrink(),
        (tags.length > 1 && tags[1].isNotEmpty) ? ListTileItem(
          icon: 'assets/images/wifi.svg',
          text: tags[1],
        ) : const SizedBox.shrink(),
        (tags.length > 2 && tags[2].isNotEmpty) ? ListTileItem(
          icon: 'assets/images/washing_machine.svg',
          text: tags[2],
        ) : const SizedBox.shrink(),
        (tags.length > 3 && tags[3].isNotEmpty) ? ListTileItem(
          icon: 'assets/images/Kitchen.svg',
          text: tags[3],
        ) : const SizedBox.shrink(),
        (tags.length > 4 && tags[4].isNotEmpty) ? ListTileItem(
          icon: 'assets/images/king_bed.svg',
          text: tags[4],
        ) : const SizedBox.shrink(),
        (tags.length > 5 && tags[5].isNotEmpty) ? ListTileItem(
          icon: 'assets/images/car.svg',
          text: tags[5],
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
