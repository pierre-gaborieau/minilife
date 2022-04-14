import 'dart:math';

import 'package:minilife/Model/Leisure/Music/instrument_brand.dart';

class InstrumentObject {
  final InstrumentModels brand;
  final String? signaturePseudo;
  int price;
  int popularity;
  int inspiration;
  int albumRecords = 0;

  InstrumentObject({
    required this.brand,
    this.signaturePseudo,
    required this.price,
    required this.popularity,
    required this.inspiration,
  });

  updatePopularityAndPrice() {
    if (popularity > 10) {
      popularity = nextInt(popularity - 10, popularity + 10);
      if (popularity < 0) popularity = 0;
      if (popularity > 100) popularity = 100;
    }

    if (popularity <= 50) {
      price = nextInt((price * 0.7).toInt(), price);
    } else {
      price = nextInt(price, (price * 1.3).toInt());
    }
  }

  String getName() {
    String vretour = brand.nom;
    if (signaturePseudo != null) {
      vretour = vretour + " Signature " + signaturePseudo!;
    }
    return vretour;
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
