import '../Country/country.dart';

class House {
  final String name;
  final int rooms;
  final int bathrooms;
  final int terrainSize;
  final bool pool;
  Country? localisation;
  int value;

  House({
    required this.name,
    required this.rooms,
    required this.bathrooms,
    required this.terrainSize,
    required this.pool,
    required this.value,
  });
}
