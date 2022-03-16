import 'package:flutter/material.dart';

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: [
        ListTile(
          leading: const Icon(Icons.house_rounded),
          title: const Text("Manage Houses"),
          onTap: () => Navigator.pushNamed(context, '/houses'),
        ),
        ListTile(
          leading: const Icon(Icons.vpn_key_outlined),
          title: const Text("Manage Cars"),
          onTap: () => Navigator.pushNamed(context, '/cars'),
        ),
        ListTile(
          leading: const Icon(Icons.folder_open),
          title: const Text("Misc Objects"),
          onTap: () => Navigator.pushNamed(context, '/misc'),
        ),
        ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text("Go Shopping"),
            onTap: () => Navigator.pushNamed(context, '/shopping')),
      ],
    ));
  }
}
