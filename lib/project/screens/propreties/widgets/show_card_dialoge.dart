import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../config/widget/helper.dart';

Future<dynamic> showCardDialoge(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            height: 540,
            width: 335,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  TextWidget(
                    text: context.l10n.walletChargedTitle,
                    color: const Color(0xFF262626),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 16),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 80.0), child: Driver()),
                  const SizedBox(height: 24),
                  SizedBox(height: 130, width: 130, child: SvgPicture.asset('assets/images/component.svg')),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextWidget(
                      text: context.l10n.walletDepositMessage(500),
                      color: const Color(0xFF262626),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 136,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(color: const Color(0xFF262626), borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: context.l10n.availableBalance,
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              const TextWidget(
                                text: '15,000',
                                color: Color(0xFFFFFFFF),
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                              ),
                              TextWidget(
                                text: context.l10n.sarCurrency,
                                color: const Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFFFFF),
                              //padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              side: const BorderSide(color: Color(0xFF262626), width: 1.0, style: BorderStyle.solid),
                            ),
                            child: TextWidget(
                              text: context.l10n.doneLabel,
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
