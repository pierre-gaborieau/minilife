import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';

class RelationsScreen extends StatelessWidget {
  const RelationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        if (DataCommon.mainCharacter.mother != null)
          ListTile(
            leading: DataCommon.mainCharacter.mother!.parent.alive
                ? const Icon(Icons.woman)
                : const Icon(Icons.church_sharp),
            title: Text(DataCommon.mainCharacter.mother!.parent.getFullName()),
            subtitle: Text("Mother • " +
                (DataCommon.mainCharacter.mother!.parent.alive
                    ? ("Relation : " +
                        DataCommon.mainCharacter.mother!.relation.toString() +
                        "%")
                    : "Dead")),
          ),
        if (DataCommon.mainCharacter.father != null)
          ListTile(
            leading: DataCommon.mainCharacter.father!.parent.alive
                ? const Icon(Icons.man_rounded)
                : const Icon(Icons.church_sharp),
            title: Text(DataCommon.mainCharacter.father!.parent.getFullName()),
            subtitle: Text("Father • " +
                (DataCommon.mainCharacter.father!.parent.alive
                    ? ("Relation : " +
                        DataCommon.mainCharacter.father!.relation.toString() +
                        "%")
                    : "Dead")),
          ),
      ],
    ));
  }
}
