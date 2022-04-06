import 'package:minilife/Model/School/formation.dart';

class Poste {
  final String nom;
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
    required this.previousPoste,
  });
}
