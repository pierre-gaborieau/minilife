import 'package:minilife/Model/Carreer/entreprise.dart';
import 'package:minilife/Model/Carreer/poste.dart';

class JobOffer {
  final Entreprise entreprise;
  final Poste poste;
  final int salaire;
  bool alreadyAsk = false;
  int yearsInPost = 0;

  JobOffer({
    required this.entreprise,
    required this.poste,
    required this.salaire,
  });
}
