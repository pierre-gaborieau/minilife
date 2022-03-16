import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';

import '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String s = DataFeed.dataFeed;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                DataCommon.mainCharacter.ageUp();
                setState(() {
                  s = DataFeed.dataFeed;
                });
              },
              tooltip: "Age Up",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            body: TabBarView(children: [
              MainFeed(
                size: MediaQuery.of(context).size,
              ),
              const ProfessionalScreen(),
              const PropertiesScreen(),
              const RelationsScreen()
            ]),
            bottomNavigationBar: const BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 4,
              child: TabBar(
                tabs: [
                  SizedBox(height: 60, child: Icon(Icons.feed)),
                  SizedBox(
                    height: 60,
                    child: Icon(
                      Icons.wallet_travel,
                    ),
                  ),
                  SizedBox(height: 60, child: Icon(Icons.house_outlined)),
                  SizedBox(height: 60, child: Icon(Icons.switch_account))
                ],
                labelColor: Colors.blue,
              ),
            )));
  }
}
