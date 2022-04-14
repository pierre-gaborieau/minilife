import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Screens/screens.dart';
import 'Data/static_carreer.dart';

void main() async {
  runApp(const MyApp());
  await DataCommon.generateMainCharacters();
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
        '/musicCarreer': (context) => const MusicCarreer(),
        //Properties Links
        '/houses': (context) => const HousesScreen(),
        '/rent': (context) => const RentHouse(),
        '/buyHouse': (context) => const BuyHouse(),
        '/misc': (context) => const MiscScreen(),
        '/cars': (context) => const CarsScreen(),
        '/shopping': (context) => const ShoppingScreen(),
        '/musicStore': (context) => const MusicStore(),
        //Miscactions links
        '/addictions': (context) => const AddictionCenter(),
        '/musicLearn': (context) => const MusicLearn(),
      },
      debugShowCheckedModeBanner: false,
      title: 'MiniLife',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
