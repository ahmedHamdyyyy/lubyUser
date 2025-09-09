import 'package:flutter/material.dart';

// import 'package:go_router/go_router.dart';
// import '../../../../../core/app_router.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../models/review.dart';
import '../views/review_view.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    super.key,
    required this.entityId,
    this.review = ReviewModel.initial,
    required this.totalRate,
    required this.isProperty,
    required this.commentsCount,
  });
  final String entityId;
  final bool isProperty;
  final double totalRate;
  final int commentsCount;
  final ReviewModel review;
  @override
  Widget build(BuildContext context) => Container(
    height: 136,
    margin: const EdgeInsets.all(20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.lightGray),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(text: review.comment, color: Color(0xFF757575), fontSize: 16, fontWeight: FontWeight.w400),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(index < totalRate ? Icons.star : Icons.star_border, color: Color(0xFF414141), size: 20),
                    );
                  }),
                ),
                const SizedBox(width: 8),
                TextWidget(
                  text: totalRate.toStringAsFixed(1),
                  color: Color(0xFF414141),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                getIt<HomeCubit>().getReviewes(entityId, isProperty ? ReviewType.property : ReviewType.activity);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsScreen(entityId: entityId, isProperty: isProperty, review: review),
                  ),
                );
                // GoRouter.of(context).push(AppRouter.kReviewsScreen);
              },
              child: TextWidget(
                text: '$commentsCount Reviews',
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
