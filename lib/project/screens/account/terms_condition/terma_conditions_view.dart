import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../config/widget/helper.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFFFFFF),
    appBar: AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      title: Text(context.l10n.termsAndConditionsTitle),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            TextWidget(
              text: context.l10n.termsAndConditionsTitle,
              color: const Color(0xFF1C1C1C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            Text(
              textAlign: TextAlign.start,
              '${context.l10n.termsFirstParagraph}\n${context.l10n.termsStandardParagraph}',
              style: GoogleFonts.poppins(
                color: const Color(0xFF757575),
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
