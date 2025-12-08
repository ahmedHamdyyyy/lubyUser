import 'package:flutter/material.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/helper.dart';
import 'add_card_screen.dart';
import 'all_wideget_bank_card.dart';
import 'delete_card_screen.dart';
import 'edit_card_screen.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen({super.key});

  @override
  State<SavedCardsScreen> createState() => _SavedCardsScreenState();
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  void _showDeleteDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const DeleteCardDialog());
  }

  bool _isChecked = true;
  bool _isChecked_2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, "Bank Cards", AppColors.primaryTextColor),
      body: SavedCardsScreenContent(
        isFirstCardChecked: _isChecked,
        isSecondCardChecked: _isChecked_2,
        onFirstCardToggle: (value) {
          setState(() {
            _isChecked = value;
          });
        },
        onSecondCardToggle: (value) {
          setState(() {
            _isChecked_2 = value;
          });
        },
        onFirstCardEdit: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EditCardScreen()));
        },
        onFirstCardDelete: () {
          _showDeleteDialog(context);
        },
        onSecondCardEdit: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EditCardScreen()));
        },
        onSecondCardDelete: () {
          _showDeleteDialog(context);
        },
        onAddNewCard: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AddCardScreen()));
        },
      ),
    );
  }
}
