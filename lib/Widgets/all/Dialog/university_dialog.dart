import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Model/School/formation.dart';

class UniversityDialog extends StatefulWidget {
  final ValueChanged<int> update;
  const UniversityDialog({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  State<UniversityDialog> createState() => _UniversityDialogState();
}

class _UniversityDialogState extends State<UniversityDialog> {
  Formation universityChoice = StaticFormations.listUniveristy[0];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("University Cursus"),
      content: DropdownButton<Formation>(
        value: universityChoice,
        items: StaticFormations.listUniveristy
            .map<DropdownMenuItem<Formation>>((Formation item) {
          return DropdownMenuItem<Formation>(
            child: Text(item.nom),
            value: item,
          );
        }).toList(),
        onChanged: (item) {
          setState(() {
            universityChoice = item!;
          });
          universityChoice = item!;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            DataCommon.mainCharacter.dropOutSchool();
          },
          child: const Text('Drop-out school'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            widget.update(2);
            DataCommon.mainCharacter.setCurrentlyLearning(universityChoice);
          },
          child: const Text('Choose cursus'),
        ),
      ],
    );
  }
}
