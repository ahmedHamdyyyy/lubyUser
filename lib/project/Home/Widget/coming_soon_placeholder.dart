import 'package:flutter/material.dart';

class ComingSoonPlaceholder extends StatelessWidget {
  const ComingSoonPlaceholder({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
    child: Image.asset('assets/images/coming_soon.png', fit: BoxFit.cover),
  );
}
