import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Alcool/alcool.dart';

class AddictionCenter extends StatelessWidget {
  const AddictionCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          if (DataCommon.mainCharacter.numberOfAddiction() == 0)
            const ListTile(
              leading: Icon(Icons.check),
              title: Text("You have no addiction at all !"),
            ),
          for (Alcool a in DataCommon.mainCharacter.alcoolAddict)
            ListTile(
              leading: const Icon(Icons.no_drinks),
              title: Text("Try to stop " + a.name),
              onTap: () {
                DataCommon.mainCharacter.alcoolTherapy(a);
                Navigator.pop(context);
              },
            )
        ],
      ),
    );
  }
}
