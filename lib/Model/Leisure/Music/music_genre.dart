import 'dart:math';

class Genre {
  final String nom;
  int popularity;

  Genre({
    required this.nom,
    required this.popularity,
  });

  updatePopularity() {
    int min = popularity - 10;
    int max = popularity + 10;
    if (min < 0) min = 0;
    if (max < 0) max = 1;
    if (max > 101) max = 101;
    popularity = nextInt(min, max);
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
