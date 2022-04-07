import 'package:flutter/material.dart';

import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';

class ActualJob extends StatelessWidget {
  const ActualJob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JobOffer actualJobOffer = DataCommon.mainCharacter.actualJobOffer!;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        ListTile(
          leading: actualJobOffer.entreprise.milieu.icon,
          title: Text(
              actualJobOffer.poste.nom + " • " + actualJobOffer.entreprise.nom),
        ),
        ListTile(
          leading: const Icon(Icons.euro_rounded),
          title: Text(
              DataCommon.mainCharacter.actualJobOffer!.salaire.toString() +
                  "k € annualy"),
        ),
        ListTile(
          leading: const Icon(Icons.publish_outlined),
          title: const Text("Ask for a promotion"),
          onTap: () {
            DataCommon.mainCharacter.askPromotion();
            Navigator.pop(context, true);
          },
        ),
        ListTile(
          leading: const Icon(Icons.euro_rounded),
          title: const Text("Ask for a payrise"),
          onTap: () {
            DataCommon.mainCharacter.askPayrise(true);
            Navigator.pop(context, true);
          },
        ),
        ListTile(
          leading: const Icon(Icons.cancel_outlined),
          title: const Text("Resign"),
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context2) => AlertDialog(
                      content:
                          const Text("Are you sure to resign from this job ?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context2),
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              DataCommon.mainCharacter.resign();
                              Navigator.pop(context2);
                              Navigator.pop(context, true);
                            },
                            child: const Text("Resign"))
                      ],
                    ));
          },
        ),
      ]),
    );
  }
}
