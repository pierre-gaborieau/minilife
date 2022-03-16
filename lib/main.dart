import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Screens/screens.dart';

import 'Data/data_feed.dart';

void main() {
  runApp(const MyApp());
  DataFeed.addEvent("You were born as " +
      DataCommon.mainCharacter.firstName +
      " " +
      DataCommon.mainCharacter.lastName);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        //Professional Links
        '/education': (context) => const EducationScreen(),
        '/jobs': (context) => const JobsScreen(),
        '/specialcareers': (context) => const SpecialCareers(),
        '/cv': (context) => const CurriculumVitae(),
        //Properties Links
        '/houses': (context) => const HousesScreen(),
        '/misc': (context) => const MiscScreen(),
        '/cars': (context) => const CarsScreen(),
        '/shopping': (context) => const ShoppingScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'MiniLife',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
