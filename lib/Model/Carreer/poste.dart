import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/School/formation.dart';

class Poste {
  final String nom;
  late Carreer carreer;
  final int salaireMin;
  final int salaireMax;
  final Formation? requirement;
  Poste? previousPoste;
  late int echelon;

  Poste({
    required this.nom,
    required this.salaireMin,
    required this.salaireMax,
    required this.requirement,
  });
}
