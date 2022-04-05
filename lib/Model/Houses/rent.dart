import 'package:minilife/Model/Houses/house.dart';

class Rent {
  final House house;
  final int wage;
  final bool isBuying;
  int duration = 0;

  Rent(this.house, this.wage, this.isBuying);
}
