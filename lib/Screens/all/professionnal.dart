import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Screens/all/home_screen.dart';

class ProfessionalScreen extends StatelessWidget {
  final ValueChanged<int> update;
  const ProfessionalScreen({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: [
        if (DataCommon.mainCharacter.currentlyLearning != null)
          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: Text(DataCommon.mainCharacter.currentlyLearning!.nom),
            tileColor: Colors.grey[200],
            subtitle: Text("Performance : " +
                DataCommon.mainCharacter.performancePro!.toString() +
                " %"),
          ),
        if (DataCommon.mainCharacter.actualJobOffer != null)
          ListTile(
            leading:
                DataCommon.mainCharacter.actualJobOffer!.entreprise.milieu.icon,
            title: Text(DataCommon.mainCharacter.actualJobOffer!.poste.nom +
                " • " +
                DataCommon.mainCharacter.actualJobOffer!.entreprise.nom),
            subtitle: Text("Performance : " +
                DataCommon.mainCharacter.performancePro!.toString() +
                " %"),
            onTap: () => _navigateToActualJob(context),
          ),
        ListTile(
          leading: const Icon(Icons.menu_book_rounded),
          title: const Text("Education"),
          onTap: () => _navigateToEducation(context),
        ),
        ListTile(
          leading: const Icon(Icons.wallet_travel),
          title: const Text("Jobs"),
          onTap: () => _navigateToJobs(context),
        ),
        ListTile(
          leading: const Icon(Icons.star_border_outlined),
          title: const Text("Special Career"),
          onTap: () => Navigator.pushNamed(context, '/specialcareers'),
        ),
        if ((DataCommon.mainCharacter.yearsOfWork >= 43 ||
                DataCommon.mainCharacter.age >= 70) &&
            !DataCommon.mainCharacter.retired)
          ListTile(
              leading: const Icon(Icons.wallet_travel),
              title: const Text("Retire"),
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context2) =>
                      RetirementDialog(update: update))),
      ],
    ));
  }

  void _navigateToEducation(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/education");

    if (translate == true) {
      update(2);
    }
  }

  void _navigateToJobs(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/jobs");

    if (translate == true) {
      update(2);
    }
  }

  void _navigateToActualJob(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/actualJob");

    if (translate == true) {
      update(2);
    }
  }
}
