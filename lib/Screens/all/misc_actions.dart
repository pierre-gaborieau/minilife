import 'package:flutter/material.dart';

class MiscActions extends StatelessWidget {
  final ValueChanged<int> update;
  const MiscActions({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.local_hospital_outlined),
            title: const Text("Addiction Center"),
            onTap: () => _navigateToAddiction(context),
          ),
        ],
      ),
    );
  }

  void _navigateToAddiction(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/addictions");

    if (translate == true) {
      update(2);
    }
  }
}
