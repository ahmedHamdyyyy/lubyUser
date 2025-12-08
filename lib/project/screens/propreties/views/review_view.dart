// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../config/colors/colors.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../core/app_router.dart';
import '../../../../../config/images/assets.dart';
import '../../../../../config/widget/helper.dart';
import '../../../../config/constants/constance.dart';
import '../../../../config/widget/widget.dart';
import '../../../../core/utils/utile.dart';
import '../../../../locator.dart';
import '../../../Home/Widget/signin_placeholder.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../activities/cubit/cubit.dart';
import '../../../models/review.dart';
import '../widgets/show_review_dialoge.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({
    super.key,
    required this.entityId,
    required this.isProperty,
    required this.review,
    required this.totalRate,
  });
  final String entityId;
  final bool isProperty;
  final ReviewModel review;
  final double totalRate;
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late ReviewModel review;
  @override
  void initState() {
    review = widget.review;
    getIt<HomeCubit>().getReviewes(widget.entityId, widget.isProperty ? ReviewType.property : ReviewType.activity);
    super.initState();
  }

  @override
  void dispose() {
    getIt<HomeCubit>().clearReviews();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 44),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 24),
                color: const Color(0xFF757575),
              ),
              TextWidget(
                text: context.l10n.reviewsTitle,
                color: const Color(0xFF757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AssetsData.apartmentView), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                TextWidget(
                  text: context.l10n.rateLabel,
                  color: const Color(0xFF414141),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < widget.totalRate ? Icons.star : Icons.star_border,
                      color: const Color(0xFF414141),
                      size: 20,
                    );
                  }),
                ),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) => previous.reviews.length != current.reviews.length,
                    builder: (context, state) {
                      return TextWidget(
                        text: context.l10n.reviewsCount(state.reviews.length),
                        color: AppColors.grayTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      );
                    },
                  ),
                ),
                BlocListener<HomeCubit, HomeState>(
                  listenWhen: (previous, current) => previous.reviewStatus != current.reviewStatus,
                  listener: (context, state) {
                    switch (state.reviewStatus) {
                      case Status.loading:
                        Utils.loadingDialog(context);
                        break;
                      case Status.error:
                        Navigator.of(context).pop();
                        Utils.errorDialog(context, state.msg);
                        break;
                      case Status.success:
                        Navigator.of(context).pop();
                        if (widget.isProperty) {
                          getIt<HomeCubit>().updatePropertyReview(state.reviews.last);
                        } else {
                          getIt<ActivitiesCubit>().updateActivityReview(state.reviews.last);
                        }
                        showToast(text: context.l10n.reviewPostedSuccessfully, stute: ToustStute.success);
                        setState(() => review = state.reviews.first);
                        break;
                      default:
                        break;
                    }
                  },
                  child: BlocSelector<HomeCubit, HomeState, bool>(
                    selector: (state) => state.isSignedIn,
                    builder: (context, isSignedIn) {
                      return TextButton(
                        onPressed: () async {
                          if (!isSignedIn) {
                            await showSigninPlaceholder(context);
                            return;
                          }
                          final review = await showReviewDialoge(
                            context,
                            entityId: widget.entityId,
                            type: widget.isProperty ? ReviewType.property : ReviewType.activity,
                            review: widget.review,
                          );
                          if (review is! ReviewModel) return;
                          if (review.id.isNotEmpty) {
                            getIt<HomeCubit>().updateReview(review.id, review.comment, review.rating);
                          } else {
                            getIt<HomeCubit>().addReview(
                              ReviewModel.initial.copyWith(
                                itemId: widget.entityId,
                                comment: review.comment,
                                type: widget.isProperty ? ReviewType.property : ReviewType.activity,
                                rating: review.rating,
                              ),
                              widget.isProperty,
                            );
                          }
                        },
                        child: TextWidget(
                          text: widget.review.id.isEmpty ? context.l10n.addReview : context.l10n.editReview,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Driver(),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.reviews.isEmpty) {
                return Center(child: Padding(padding: EdgeInsetsGeometry.all(16), child: Text(context.l10n.noReviewsYet)));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.reviews.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return _buildReviewItem(state.reviews[index]);
                },
              );
            },
          ),
        ],
      ),
    ),
    //bottomNavigationBar: const BottomNavBarWidget(),
  );

  Widget _buildReviewItem(ReviewModel review) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: FadeInImage.assetNetwork(
                placeholder: AssetsData.host2,
                image: review.profilePicture,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(AssetsData.host2, fit: BoxFit.cover);
                },
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: '${review.userFirstName} ${review.userLastName}',
                  color: Color(0xFF414141),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    TextWidget(
                      text: context.l10n.rateLabel,
                      color: const Color(0xFF414141),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: List.generate(
                        review.rating.toInt(),
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
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextWidget(text: review.comment, color: Color(0xFF757575), fontSize: 16, fontWeight: FontWeight.w400),
      ),
      const Driver(),
    ],
  );
}
