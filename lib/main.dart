import 'package:flutter/material.dart';
import 'package:minilife/Screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/education': (context) => const EducationScreen(),
        '/jobs': (context) => const JobsScreen(),
        '/specialcareers': (context) => const SpecialCareers()
      },
      debugShowCheckedModeBanner: false,
      title: 'MiniLife',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 4,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: null,
              tooltip: "Age Up",
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            body: TabBarView(children: [
              ProfessionalScreen(),
              MainFeed(),
              PropertiesScreen(),
              RelationsScreen()
            ]),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 4,
              child: TabBar(
                tabs: [
                  SizedBox(
                    height: 60,
                    child: Icon(
                      Icons.wallet_travel,
                    ),
                  ),
                  SizedBox(height: 60, child: Icon(Icons.feed)),
                  SizedBox(height: 60, child: Icon(Icons.house_outlined)),
                  SizedBox(height: 60, child: Icon(Icons.switch_account))
                ],
                labelColor: Colors.blue,
              ),
            )));
  }
}
