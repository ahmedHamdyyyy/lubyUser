import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../core/app_router.dart';
import '../../../../../../config/images/assets.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/widget/helper.dart';
import '../widgets/show_review_dialoge.dart';
import 'rental_details_view.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RentalDetailScreen(id: '', index: 0)));
                    // GoRouter.of(context)
                    //     .pushReplacement(AppRouter.kRentalDetailView);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 24,
                  ),
                  color: const Color(0xFF757575),
                ),
                const TextWidget(
                  text: 'Reviews',
                  color: Color(0xFF757575),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetsData.apartmentView),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: 'Apartment',
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  TextButton(
                    onPressed: () {
                      showReviewDialoge(context);
                    },
                    child: const TextWidget(
                      text: 'Add Review',
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  const TextWidget(
                    text: 'Rate ',
                    color: Color(0xFF414141),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
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
                  const TextWidget(
                    text: ' ( 9 Reviews )',
                    color: AppColors.grayTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const Driver(),
            ...List.generate(
              4,
              (index) => _buildReviewItem(),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: const BottomNavBarWidget(),
    );
  }

  Widget _buildReviewItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsData.host2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Mohamed Ahmed',
                    color: Color(0xFF414141),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const TextWidget(
                        text: 'Rate ',
                        color: Color(0xFF414141),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
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
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextWidget(
            text:
                'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text Diam habitant.',
            color: Color(0xFF757575),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Driver(),
      ],
    );
  }
}
