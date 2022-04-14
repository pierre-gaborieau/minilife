import 'package:minilife/Model/Human/human.dart';

class ChildrenRelation {
  final Human parent;
  final bool isAdopted;
  final bool isStep;
  int relation = 100;

  ChildrenRelation({
    required this.parent,
    required this.isAdopted,
    required this.isStep,
  });
}
