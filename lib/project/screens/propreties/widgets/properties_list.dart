import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../Home/Widget/coming_soon_placeholder.dart';
import '../../../Home/cubit/home_cubit.dart';
import 'property_card.dart';

class PropertiesList extends StatelessWidget {
  const PropertiesList({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      if (state.propertiesStatus == Status.loading && state.properties.isEmpty) {
        return const SizedBox(height: 350, width: double.infinity, child: Center(child: CircularProgressIndicator()));
      }
      if (state.properties.isEmpty) return const ComingSoonPlaceholder();
      return Column(
        children: [
          GridView.builder(
            itemCount: state.properties.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            cacheExtent: 800,
            addAutomaticKeepAlives: false,
            addSemanticIndexes: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder:
                (context, index) => RepaintBoundary(
                  key: ValueKey(state.properties[index].id),
                  child: PropertyCard(property: state.properties[index]),
                ),
          ),
          if (state.propertiesStatus == Status.loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(height: 28, width: 28, child: CircularProgressIndicator(strokeWidth: 2)),
            ),
        ],
      );
    },
  );
}
