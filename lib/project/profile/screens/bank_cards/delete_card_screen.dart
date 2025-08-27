import 'package:flutter/material.dart';
import 'all_wideget_bank_card.dart';


class DeleteCardDialog extends StatelessWidget {
  const DeleteCardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DeleteCardDialogWidget(
      onConfirm: () {
        Navigator.pop(context); // Confirm deletion and close dialog
      },
      onCancel: () {
        Navigator.pop(context); // Cancel and close dialog
      },
    );
  }
}
