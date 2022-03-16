import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Data/static_milieu.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Carreer/poste.dart';

class StaticCarreer {
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
        previousPoste: computerScienceCarreer.listPoste[0])
  ]);
}
