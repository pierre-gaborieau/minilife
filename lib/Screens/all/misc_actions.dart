import 'package:flutter/material.dart';

class MiscActions extends StatelessWidget {
  const MiscActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.local_hospital_outlined),
            title: const Text("Addiction Center"),
            onTap: () => Navigator.pushNamed(context, '/addictions'),
          ),
        ],
      ),
    );
  }
}
