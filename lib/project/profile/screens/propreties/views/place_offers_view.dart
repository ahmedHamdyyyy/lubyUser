import 'package:flutter/material.dart';
import 'package:luby2/core/localization/l10n_ext.dart';
import 'package:luby2/project/profile/screens/propreties/widgets/list_tile_item.dart';

import '../../../../../../config/widget/helper.dart';

class PlaceOffersView extends StatelessWidget {
  final List<String> tags;
  const PlaceOffersView({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 24),
                  color: const Color(0xFF757575),
                ),
                const SizedBox(width: 8),
                TextWidget(
                  text: context.l10n.whatThisPlaceOffers,
                  color: Color(0xFF414141),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: tags.length,
              itemBuilder: (context, index) => ListTileItem(text: tags[index]),
            ),
          ),
        ],
      ),
    );
  }
}
