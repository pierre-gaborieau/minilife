import 'dart:math';

import 'package:minilife/Model/SpecialCarreer/celebrity_spe.dart';

class Celebrity {
  String name;
  int fanbase;
  List<CelebritySpe> listSpe = [];

  Celebrity({
    required this.name,
    required this.fanbase,
  });

  getPseudo() {
    return name;
  }

  updateFanbase() {
    int min = (fanbase * 0.7).toInt();
    int max = fanbase;
    if (min < 0) min = 0;
    if (max <= 0) max = 1;

    fanbase = nextInt(min, max);
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
