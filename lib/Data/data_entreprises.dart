import 'package:minilife/Data/static_milieu.dart';
import 'package:minilife/Model/Carreer/entreprise.dart';

class DataEntreprise {
  static List<Entreprise> miniComputerList = [
    Entreprise("NanoInfo", false, StaticMilieu.milieuTechnology),
    Entreprise("MobileCreations", false, StaticMilieu.milieuTechnology),
    Entreprise("Db Expert", false, StaticMilieu.milieuTechnology),
    Entreprise("SocialUS", false, StaticMilieu.milieuTechnology)
  ];

  static List<Entreprise> listFastFood = [
    Entreprise("Burgers4All", true, StaticMilieu.milieuRestaurant),
    Entreprise("EasyDonuts", true, StaticMilieu.milieuRestaurant),
    Entreprise("YumYumRamen", true, StaticMilieu.milieuRestaurant),
  ];

  static List<Entreprise> listRestaurant = [
    Entreprise("Rendez-vous", false, StaticMilieu.milieuRestaurant),
    Entreprise("The Indian Diner", false, StaticMilieu.milieuRestaurant),
  ];

  static List<Entreprise> computerList = [
    Entreprise("Outside Technology", true, StaticMilieu.milieuTechnology),
    Entreprise("Lemon Inc", true, StaticMilieu.milieuTechnology)
  ];

  static List<Entreprise> financialList = [
    Entreprise("Billionaire Consulting", true, StaticMilieu.milieuEconomy),
    Entreprise("MoneyFinder", true, StaticMilieu.milieuEconomy),
    Entreprise("RichBuilders", true, StaticMilieu.milieuEconomy),
    Entreprise("John Doe Foundation", true, StaticMilieu.milieuEconomy),
  ];

  static List<Entreprise> journalismList = [
    Entreprise("GameNews", false, StaticMilieu.milieuJournalism),
    Entreprise("Metal Music", false, StaticMilieu.milieuJournalism),
    Entreprise("SatyricNews", false, StaticMilieu.milieuJournalism),
    Entreprise("People Newz", true, StaticMilieu.milieuJournalism),
    Entreprise("National Report", true, StaticMilieu.milieuJournalism),
    Entreprise("The Expert", true, StaticMilieu.milieuJournalism),
    Entreprise("Politizer", true, StaticMilieu.milieuJournalism),
    Entreprise("InternationalNews", true, StaticMilieu.milieuJournalism),
  ];
}
