import 'package:minilife/Data/static_milieu.dart';
import 'package:minilife/Model/Carreer/entreprise.dart';

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
}
