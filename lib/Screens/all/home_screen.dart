import 'package:flutter/material.dart';

import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Model/School/formation.dart';

import '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String s = DataFeed.dataFeed;

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    void _update(int position) {
      setState(() {
        _controller.animateTo(position);
      });
    }

    return DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                bool needRefresh =
                    DataCommon.mainCharacter.ageUp(context, _update);
                setState(() {
                  s = DataFeed.dataFeed;
                  _controller.animateTo(2);
                });
                if (needRefresh) {
                  s = DataFeed.dataFeed;
                  _controller.animateTo(2);
                }
              },
              tooltip: "Age Up",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            body: TabBarView(controller: _controller, children: [
              ProfessionalScreen(update: _update),
              PropertiesScreen(update: _update),
              MainFeed(
                size: MediaQuery.of(context).size,
              ),
              const RelationsScreen(),
              MiscActions(
                update: _update,
              ),
            ]),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 4,
              child: TabBar(
                controller: _controller,
                tabs: const [
                  SizedBox(
                    height: 80,
                    child: Icon(
                      Icons.wallet_travel,
                    ),
                  ),
                  SizedBox(height: 80, child: Icon(Icons.house_outlined)),
                  SizedBox(height: 80, child: Icon(Icons.feed)),
                  SizedBox(height: 80, child: Icon(Icons.switch_account)),
                  SizedBox(
                    height: 80,
                    child: Icon(Icons.star_border),
                  ),
                ],
                labelColor: Colors.blue,
              ),
            )));
  }
}

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
