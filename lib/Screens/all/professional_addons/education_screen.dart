import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_formations.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          if (DataCommon.mainCharacter.age < StaticFormations.agePrimary)
            const ListTile(
              leading: Icon(Icons.bedroom_baby_outlined),
              title: Text("Wait ! You're still a baby !"),
            ),
          if (DataCommon.mainCharacter.listFormations.isNotEmpty ||
              DataCommon.mainCharacter.career.isNotEmpty)
            ListTile(
              tileColor: Colors.grey[200],
              leading: const Icon(Icons.book),
              title: const Text("Curriculum Vitae"),
              onTap: () => Navigator.pushNamed(context, '/cv'),
            ),
          if (DataCommon.mainCharacter.currentlyLearning != null)
            ListTile(
              leading: const Icon(Icons.border_color_rounded),
              title: Text(DataCommon.mainCharacter.currentlyLearning!.nom),
              subtitle: Text("Years left : " +
                  DataCommon.mainCharacter.currentlyLearning!
                      .yearsLeft(DataCommon.mainCharacter.age)
                      .toString() +
                  " Performance : " +
                  DataCommon.mainCharacter.performancePro.toString() +
                  " %"),
              tileColor: Colors.grey[200],
            ),
          if (DataCommon.mainCharacter.isLearning &&
              DataCommon.mainCharacter.canWorkHarder)
            ListTile(
              tileColor: Colors.grey[200],
              leading: const Icon(Icons.edit_outlined),
              title: const Text("Work Harder !"),
              onTap: () {
                Navigator.pop(context, true);
                DataCommon.mainCharacter.workharder();
              },
            ),
          if (DataCommon.mainCharacter.age >= StaticFormations.minDropOutAge &&
              DataCommon.mainCharacter.isLearning)
            ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Dropout School"),
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context2) => AlertDialog(
                            content: const Text(
                                "Do you really want to drop-out school ?\nYou won't be able to get back to it."),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context2),
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    DataCommon.mainCharacter.dropOutSchool();
                                    Navigator.pop(context);
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Drop-out"))
                            ],
                          ));
                }),
          if (DataCommon.mainCharacter.actualJobOffer != null &&
              DataCommon.mainCharacter.actualJobOffer!.poste.requirement !=
                  null &&
              !DataCommon.mainCharacter.listFormations.contains(
                  DataCommon.mainCharacter.actualJobOffer!.poste.requirement!))
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: Text("Try to validate : " +
                  DataCommon
                      .mainCharacter.actualJobOffer!.poste.requirement!.nom),
              onTap: () {
                DataCommon.mainCharacter.validateSchoolRequirement(DataCommon
                    .mainCharacter.actualJobOffer!.poste.requirement!);
                Navigator.pop(context, true);
              },
            )
        ],
      ),
    );
  }
}
