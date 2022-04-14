import 'package:minilife/Model/Leisure/Music/instrument.dart';

class InstrumentModels {
  final String nom;
  int popularity;
  int minPrice;
  int maxPrice;
  final Instrument instrument;
  InstrumentModels({
    required this.nom,
    required this.popularity,
    required this.minPrice,
    required this.maxPrice,
    required this.instrument,
  });
}
