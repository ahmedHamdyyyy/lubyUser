import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:go_router/go_router.dart';
// import '../../../../../core/app_router.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../models/review.dart';
import '../views/review_view.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          const TextWidget(
            text: 'One of the most loved homes on',
            color: Color(0xFF757575),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          const TextWidget(
            text: 'Loby based on ratings, reviews and reliability.',
            color: Color(0xFF757575),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: SvgPicture.asset(
                          'assets/images/stare.svg',
                          // ignore: deprecated_member_use
                          color: const Color(0xFF414141),
                          height: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const TextWidget(text: '5.0', color: Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w500),
                ],
              ),
              InkWell(
                onTap: () {
                  getIt<HomeCubit>().getReviewes(id, ReviewType.property);
                  final property = getIt<HomeCubit>().state.property;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ReviewsScreen(
                          comment: '',
                          itemId: id,
                          rate: 5,
                          type: ReviewType.property,
                          reviewId: property.reviewId,
                        );
                      },
                    ),
                  );
                  // GoRouter.of(context).push(AppRouter.kReviewsScreen);
                },
                child: const TextWidget(
                  text: '9 Reviews',
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
}
