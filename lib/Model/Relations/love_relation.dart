import 'package:minilife/Model/Human/human.dart';

class LoveRelation {
  final Human loverA;
  final Human loverB;
  bool married = false;
  bool houseTogether = false;
  late int balance;

  LoveRelation(this.loverA, this.loverB);

  pay(int amount) {
    if (married) {
      balance -= amount;
    } else {
      loverA.balance -= amount ~/ 2;
      loverB.balance -= amount ~/ 2;
    }
  }
}
