import 'dart:math';

import 'package:minilife/Data/data_entreprises.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Data/static_milieu.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Carreer/entreprise.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/Carreer/poste.dart';

class StaticCarreer {
  static void updatePreviousPoste(Carreer carreer) {
    for (int i = 0; i < carreer.listPoste!.length; i++) {
      if (i > 0) {
        carreer.listPoste![i].previousPoste = carreer.listPoste![i - 1];
      }
    }
  }

  static int minAgeTravail = 16;

  static Carreer computerScienceCarreer =
      Carreer("Computer Science", StaticMilieu.milieuTechnology, [
    Poste(
        nom: "Code Tester",
        salaireMin: 18,
        salaireMax: 22,
        requirement: StaticFormations.formationComputerScience,
        previousPoste: null),
    Poste(
        nom: "Junior Developper",
        salaireMin: 25,
        salaireMax: 35,
        requirement: StaticFormations.formationComputerScience,
        previousPoste: null),
    Poste(
        nom: "Senior Developper",
        salaireMin: 33,
        salaireMax: 60,
        requirement: StaticFormations.formationComputerScience,
        previousPoste: null)
  ]);

  static Carreer restaurationCarreer =
      Carreer("Restauration", StaticMilieu.milieuRestaurant, [
    Poste(
        nom: "Dish Cleaner",
        salaireMin: 17,
        salaireMax: 20,
        requirement: null,
        previousPoste: null),
    Poste(
        nom: "Waiter",
        salaireMin: 18,
        salaireMax: 25,
        requirement: StaticFormations.formationSecondary,
        previousPoste: null),
    Poste(
        nom: "Junior Cook",
        salaireMin: 20,
        salaireMax: 27,
        requirement: StaticFormations.formationSecondary,
        previousPoste: null),
    Poste(
        nom: "Cook",
        salaireMin: 23,
        salaireMax: 30,
        requirement: StaticFormations.formationSecondary,
        previousPoste: null),
    Poste(
        nom: "Chef",
        salaireMin: 25,
        salaireMax: 70,
        requirement: StaticFormations.formationSecondary,
        previousPoste: null)
  ]);

  static Carreer financialCarreer =
      Carreer("Economy", StaticMilieu.milieuEconomy, [
    Poste(
        nom: "Accountant",
        salaireMin: 20,
        salaireMax: 25,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
    Poste(
        nom: "Business Analyst",
        salaireMin: 22,
        salaireMax: 30,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
    Poste(
        nom: "Senior Business Analyst",
        salaireMin: 28,
        salaireMax: 42,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
    Poste(
        nom: "Financial Advisor",
        salaireMin: 28,
        salaireMax: 47,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
    Poste(
        nom: "Financial Analyst",
        salaireMin: 35,
        salaireMax: 55,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
    Poste(
        nom: "Stockbrocker",
        salaireMin: 40,
        salaireMax: 110,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
    Poste(
        nom: "Financial Expert",
        salaireMin: 70,
        salaireMax: 145,
        requirement: StaticFormations.formationEconomy,
        previousPoste: null),
  ]);

  static List<JobOffer> jobOffer = [];

  static void regenerateJobOffer() {
    jobOffer.clear();
    jobOffer = [
      generateOffer(computerScienceCarreer, DataEntreprise.computerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(restaurationCarreer, DataEntreprise.listFastFood),
      generateOffer(restaurationCarreer, DataEntreprise.listFastFood),
      generateOffer(restaurationCarreer, DataEntreprise.listFastFood),
      generateOffer(restaurationCarreer, DataEntreprise.listRestaurant),
      generateOffer(financialCarreer, DataEntreprise.financialList),
      generateOffer(financialCarreer, DataEntreprise.financialList),
    ];
  }

  static JobOffer generateOffer(Carreer wanted, List<Entreprise> entreprises) {
    Poste tmp = wanted.listPoste![Random().nextInt(wanted.listPoste!.length)];
    JobOffer offer = JobOffer(
        entreprise: entreprises[Random().nextInt(entreprises.length)],
        poste: tmp,
        salaire: nextInt(tmp.salaireMin, tmp.salaireMax));
    return offer;
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
