import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';

class RetirementDialog extends StatelessWidget {
  final ValueChanged<int> update;
  const RetirementDialog({Key? key, required this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
          "You can now take your retirement. Do you wan't to take it or do you wan't to continue working ?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Continue")),
        TextButton(
            onPressed: () {
              DataCommon.mainCharacter.retire();
              Navigator.pop(context);
              update(2);
            },
            child: const Text("Retire"))
      ],
    );
  }
}
