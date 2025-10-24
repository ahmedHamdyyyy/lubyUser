import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luby2/config/widget/widget.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../activities/cubit/cubit.dart';
import '../../../../models/review.dart';
import 'custom_text_filed.dart';

Future<dynamic> showReviewDialoge(
  BuildContext context, {
  required ReviewType type,
  required String entityId,
  required ReviewModel review,
}) {
  getIt<HomeCubit>().initReviewStatus();
  final commentController = TextEditingController(text: review.comment);
  int rate = review.rating;
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, right: 20),
                          child: SvgPicture.asset(
                            'assets/images/close-square.svg',
                            // ignore: deprecated_member_use
                            color: const Color(0xFF414141),
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    text: review.id.isEmpty ? context.l10n.addReview : context.l10n.editReview,
                    color: const Color(0xFF262626),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 16),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 80.0), child: Driver()),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: context.l10n.rateApartment,
                          color: Color(0xFF414141),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 8),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: InkWell(
                                    onTap: () => setState(() => rate = index + 1),
                                    child: Icon(
                                      rate > index ? Icons.star : Icons.star_border,
                                      color: const Color(0xFF414141),
                                      size: 18,
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: TextWidget(
                          text: context.l10n.addComment,
                          color: Color(0xFF414141),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24, right: 4, top: 8),
                        child: CustomTextField(
                          controller: commentController,
                          maxLines: 4,
                          text: context.l10n.addYourCommentHere,
                          height: 90,
                          width: 295,
                        ),
                      ),
                    ],
                  ),
                  BlocListener<HomeCubit, HomeState>(
                    listener: (context, state) {
                      switch (state.reviewStatus) {
                        case Status.loading:
                          Utils.loadingDialog(context);
                          break;
                        case Status.error:
                          Navigator.pop(context);
                          Utils.errorDialog(context, state.msg);
                          break;
                        case Status.success:
                          Navigator.pop(context);
                          Navigator.pop(context);
                          if (type == ReviewType.activity) {
                            getIt<ActivitiesCubit>().updateActivityReview(state.reviews.last);
                          } else {
                            getIt<HomeCubit>().updatePropertyReview(state.reviews.last);
                          }
                          showToast(text: context.l10n.reviewPostedSuccessfully, stute: ToustStute.success);
                          break;
                        default:
                          break;
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        if (review.id.isNotEmpty) {
                          getIt<HomeCubit>().updateReview(review.id, commentController.text.trim(), rate);
                        } else {
                          getIt<HomeCubit>().addReview(
                            ReviewModel.initial.copyWith(
                              itemId: entityId,
                              comment: commentController.text.trim(),
                              type: type,
                              rating: rate,
                            ),
                            type == ReviewType.property,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF262626),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: TextWidget(
                        text: context.l10n.addLabel,
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
