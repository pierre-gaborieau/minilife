import 'dart:math';

import 'package:minilife/Data/static_carreer.dart';
import 'package:minilife/Data/static_milieu.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Carreer/entreprise.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/Carreer/poste.dart';

class DataEntreprise {
  static Entreprise miniComputerOne =
      Entreprise("NanoInfo", false, StaticMilieu.milieuTechnology);
  static Entreprise miniComputerTwo =
      Entreprise("MobileCreations", false, StaticMilieu.milieuTechnology);
  static Entreprise miniComputerThree =
      Entreprise("Db Expert", false, StaticMilieu.milieuTechnology);
  static Entreprise miniComputerFour =
      Entreprise("SocialUS", false, StaticMilieu.milieuTechnology);

  static Entreprise computerOne =
      Entreprise("Outside Technology", true, StaticMilieu.milieuTechnology);
  static Entreprise computerTwo =
      Entreprise("Lemon Inc", true, StaticMilieu.milieuTechnology);

  static List<Entreprise> miniComputerList = [
    miniComputerOne,
    miniComputerTwo,
    miniComputerThree,
    miniComputerFour
  ];

  static List<Entreprise> computerList = [computerOne, computerTwo];

  List<JobOffer> generateJobOffers() {
    List<JobOffer> vretour = [
      generateOffer(StaticCarreer.computerScienceCarreer, miniComputerList),
      generateOffer(StaticCarreer.computerScienceCarreer, miniComputerList),
      generateOffer(StaticCarreer.computerScienceCarreer, miniComputerList),
      generateOffer(StaticCarreer.computerScienceCarreer, miniComputerList),
    ];

    return vretour;
  }

  JobOffer generateOffer(Carreer wanted, List<Entreprise> entreprises) {
    Poste tmp = wanted.listPoste[Random().nextInt(wanted.listPoste.length + 1)];
    JobOffer offer = JobOffer(
        entreprise: entreprises[Random().nextInt(entreprises.length + 1)],
        poste: tmp,
        salaire: nextInt(tmp.salaireMin, tmp.salaireMax));
    return offer;
  }

  int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
