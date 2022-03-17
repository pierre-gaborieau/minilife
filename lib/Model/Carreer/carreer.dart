import 'package:minilife/Model/Carreer/poste.dart';
import 'package:minilife/Model/Milieu/milieu.dart';

class Carreer {
  final String nom;
  final Milieu milieu;
  List<Poste>? listPoste;

  Carreer(
    this.nom,
    this.milieu,
    this.listPoste,
  );
}
