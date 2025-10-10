import 'package:flutter/material.dart';

import '../../../../../../config/widget/helper.dart';
import '../views/place_offers_view.dart';
import 'list_tile_item.dart';

class AmenitiesWidget extends StatelessWidget {
  final List<String> tags;
  const AmenitiesWidget({super.key, required this.tags});
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        TileItemList(tags: tags),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 240,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOffersView(tags: tags)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF262626),
                  elevation: 0,
                  padding: const EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: const TextWidget(
                  text: 'Show All Amenities',
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

class TileItemList extends StatelessWidget {
  const TileItemList({super.key, required this.tags});
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(tags.length > 3 ? 3 : tags.length, (index) {
        return ListTileItem(text: tags[index]);
      }),
    );
  }
}

// class AmenitiesWidgetActivity extends StatelessWidget {
//   final ActivityModel state;
//   const AmenitiesWidgetActivity({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const TextWidget(
//             text: 'What this place offers',

//             color: Color(0xFF414141),
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//           const SizedBox(height: 16),
//           TileItemListActivity(state: state),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 240,
//                 height: 35,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOffersViewActivity(state: state)));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF262626),
//                     elevation: 0,
//                     padding: const EdgeInsets.only(bottom: 2),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                   ),
//                   child: const TextWidget(
//                     text: 'Show All Amenities',
//                     color: Color(0xFFFFFFFF),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TileItemListActivity extends StatelessWidget {
//   final ActivityModel state;
//   const TileItemListActivity({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final tags = state.tags;
//     return Column(
//       children: [
//         (tags.isNotEmpty && tags[0].isNotEmpty)
//             ? ListTileItem(icon: 'assets/images/waterfront.svg', text: tags[0])
//             : const SizedBox.shrink(),
//         (tags.length > 1 && tags[1].isNotEmpty)
//             ? ListTileItem(icon: 'assets/images/wifi.svg', text: tags[1])
//             : const SizedBox.shrink(),
//         (tags.length > 2 && tags[2].isNotEmpty)
//             ? ListTileItem(icon: 'assets/images/washing_machine.svg', text: tags[2])
//             : const SizedBox.shrink(),
//       ],
//     );
//   }
// }
