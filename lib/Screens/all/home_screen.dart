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
        initialIndex: 2,
        length: 5,
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
              const ProfessionalScreen(),
              const PropertiesScreen(),
              MainFeed(
                size: MediaQuery.of(context).size,
              ),
              const RelationsScreen(),
              const MiscActions(),
            ]),
            bottomNavigationBar: const BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 4,
              child: TabBar(
                tabs: [
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
