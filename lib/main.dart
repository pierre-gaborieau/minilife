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
        //Professional Links
        '/education': (context) => const EducationScreen(),
        '/jobs': (context) => const JobsScreen(),
        '/specialcareers': (context) => const SpecialCareers(),
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
