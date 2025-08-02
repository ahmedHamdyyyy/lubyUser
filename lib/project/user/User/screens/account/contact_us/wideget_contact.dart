import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/widget/helper.dart';
import '../../propreties/widgets/custom_text_filed.dart';

// Contact Us Header Widget
class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
              ),
              color: const Color(0xFF757575),
            ),
            const TextWidget(
              text: 'Contact Us',
              color: Color(0xFF757575),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: TextWidget(
            text: 'Contact Us',
            color: Color(0xFF1C1C1C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Phone Number Widget
class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const TextWidget(
            text: '+966 123456789',
            color: Color(0xFF636363),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          const Spacer(),
          Material(
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF262626),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.asset(
                  'assets/images/call-calling.svg',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Message Form Widget
class MessageFormWidget extends StatelessWidget {
  const MessageFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'How can we help you ?',
            color: Color(0xFF636363),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 16),
          CustomTextField(
            text: 'You can add your message here',
            maxLines: 7,
            height: 235,
            width: 335,
          ),
        ],
      ),
    );
  }
}

// Send Button Widget
class SendButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SendButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF262626),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const TextWidget(
            text: 'Send',
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Main Content Widget that combines all components
class ContactUsContent extends StatelessWidget {
  final VoidCallback onSendPressed;

  const ContactUsContent({
    super.key,
    required this.onSendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ContactUsHeader(),
        const PhoneNumberWidget(),
        const SizedBox(height: 24),
        const MessageFormWidget(),
        const SizedBox(height: 24),
        SendButtonWidget(onPressed: onSendPressed),
      ],
    );
  }
}
