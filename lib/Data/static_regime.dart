import 'package:minilife/Model/Health/regime.dart';

class StaticRegime {
  static List<Regime> listRegime = [
    Regime("Fast-Food lovers", 1820, -10, 10),
    Regime("Fast-Food/Mall", 2500, -5, 5),
    Regime("Mall Lovers", 3640, 0, -3),
    Regime("Mall/Garden", 3800, 2, 0),
    Regime("Garden Lover", 5000, 3, 2),
    Regime("Garden/Personnal Chief", 10000, 5, 10),
    Regime("Personnal Chief", 25000, 15, 20),
  ];
}
