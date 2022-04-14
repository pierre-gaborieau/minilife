import '../Country/country.dart';

class House {
  final String name;
  final int rooms;
  final int bathrooms;
  final int terrainSize;
  final bool pool;
  Country? localisation;
  int value;
  final int minAnnualPrice;
  final int maxAnnualPrice;

  House({
    required this.name,
    required this.rooms,
    required this.bathrooms,
    required this.terrainSize,
    required this.pool,
    this.localisation,
    required this.value,
    required this.minAnnualPrice,
    required this.maxAnnualPrice,
  });
}
