import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Screens/all/professional_addons/actual_job.dart';
import 'package:minilife/Screens/all/properties_addons/buy_house.dart';
import 'package:minilife/Screens/all/properties_addons/rent_house.dart';
import 'package:minilife/Screens/screens.dart';
import 'Data/static_carreer.dart';

void main() {
  runApp(const MyApp());
  DataCommon.generateMainCharacter();
  StaticHouse.generateRent();
  StaticHouse.generateSell();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StaticCarreer.updatePreviousPoste(StaticCarreer.computerScienceCarreer);
    StaticCarreer.updatePreviousPoste(StaticCarreer.restaurationCarreer);
    StaticCarreer.updatePreviousPoste(StaticCarreer.journalismCarreer);
    StaticCarreer.updatePreviousPoste(StaticCarreer.financialCarreer);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        //Professional Links
        '/education': (context) => const EducationScreen(),
        '/jobs': (context) => const JobsScreen(),
        '/specialcareers': (context) => const SpecialCareers(),
        '/cv': (context) => const CurriculumVitae(),
        '/actualJob': (context) => const ActualJob(),
        //Properties Links
        '/houses': (context) => const HousesScreen(),
        '/rent': (context) => const RentHouse(),
        '/buyHouse': (context) => const BuyHouse(),
        '/misc': (context) => const MiscScreen(),
        '/cars': (context) => const CarsScreen(),
        '/shopping': (context) => const ShoppingScreen(),
        //Miscactions links
        '/addictions': (context) => const AddictionCenter(),
      },
      debugShowCheckedModeBanner: false,
      title: 'MiniLife',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
