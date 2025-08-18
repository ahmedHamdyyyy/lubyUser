import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luby2/config/widget/widget.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../models/review.dart';
import 'custom_text_filed.dart';

Future<dynamic> showReviewDialoge(
  BuildContext context, {
  required ReviewType type,
  String id = '',
  required String itemId,
  int rate = 5,
  String comment = '',
}) {
  getIt<HomeCubit>().initReviewStatus();
  final commentController = TextEditingController(text: comment);
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
                  const TextWidget(text: 'Add Review', color: Color(0xFF262626), fontSize: 16, fontWeight: FontWeight.w600),
                  const SizedBox(height: 16),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 80.0), child: Driver()),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: 'Rate Apartment',
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
                          text: 'Add Comment',
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
                          text: 'Add your comment here',
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
                          showToast(text: 'review posted successfully', stute: ToustStute.success);
                          break;
                        default:
                          break;
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        if (id.isNotEmpty) {
                          getIt<HomeCubit>().updateReview(id, commentController.text.trim(), rate);
                        } else {
                          final review = ReviewModel.initial.copyWith(
                            id: id,
                            itemId: itemId,
                            comment: commentController.text.trim(),
                            type: type,
                            rating: rate,
                          );
                          getIt<HomeCubit>().addReview(review);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF262626),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const TextWidget(
                        text: 'Add',
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
