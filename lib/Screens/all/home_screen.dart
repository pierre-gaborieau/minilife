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
