import 'package:flutter/material.dart';

class PropertiesScreen extends StatelessWidget {
  final ValueChanged<int> update;
  const PropertiesScreen({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: [
        ListTile(
          leading: const Icon(Icons.house_rounded),
          title: const Text("Manage Houses"),
          onTap: () => _navigateToHouses(context),
        ),
        ListTile(
          leading: const Icon(Icons.vpn_key_outlined),
          title: const Text("Manage Cars"),
          onTap: () => Navigator.pushNamed(context, '/cars'),
        ),
        ListTile(
          leading: const Icon(Icons.folder_open),
          title: const Text("Misc Objects"),
          onTap: () => _navigateToMisc(context),
        ),
        ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text("Go Shopping"),
            onTap: () => _navigateToShop(context)),
      ],
    ));
  }

  void _navigateToHouses(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/houses");

    if (translate == true) {
      update(2);
    }
  }

  void _navigateToShop(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed('/shopping');
    if (translate == true) {
      update(2);
    }
  }

  void _navigateToMisc(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed('/misc');
    if (translate == true) {
      update(2);
    }
  }
}
