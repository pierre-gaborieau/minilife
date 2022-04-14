import 'package:flutter/material.dart';

import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';

class DeathScreen extends StatelessWidget {
  final ValueChanged<int> update;
  const DeathScreen({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _allow = false;
    return WillPopScope(
      onWillPop: () {
        return Future.value(_allow);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(DataCommon.mainCharacter.getFullName()),
              Text(DataCommon.mainCharacter.age.toString() + " years old."),
              Text(DataCommon.mainCharacter.deathReason),
              TextButton(
                  onPressed: () => _regenerateGame(context),
                  child: const Text("Start another life"))
            ],
          ),
        ),
      ),
    );
  }

  void _regenerateGame(BuildContext context) async {
    DataFeed.dataFeed = "";
    await DataCommon.generateMainCharacters();
    Navigator.pop(context);
    update(2);
  }
}
