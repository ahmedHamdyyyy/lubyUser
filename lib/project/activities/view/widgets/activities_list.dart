import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../Home/Widget/coming_soon_placeholder.dart';
import '../../cubit/cubit.dart';
import 'activity_card.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        // Show full-page loader only when first page is loading
        if (state.getAllActivitiesStatus == Status.loading && state.activities.isEmpty) {
          return const SizedBox(height: 350, width: double.infinity, child: Center(child: CircularProgressIndicator()));
        }
        if (state.activities.isEmpty) return const ComingSoonPlaceholder();

        return Column(
          children: [
            GridView.builder(
              itemCount: state.activities.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    key: ValueKey(state.activities[index].id),
                    child: ActivityCard(activity: state.activities[index]),
                  ),
            ),
            if (state.getAllActivitiesStatus == Status.loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(height: 28, width: 28, child: CircularProgressIndicator(strokeWidth: 2)),
              ),
          ],
        );
      },
    );
  }
}
