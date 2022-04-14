import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note_rounded),
            title: const Text("Music Shop"),
            onTap: () => _navigateToMusicShop(context),
          )
        ],
      ),
    );
  }
}

void _navigateToMusicShop(BuildContext context) async {
  var translate = await Navigator.of(context).pushNamed('/musicStore');

  if (translate == true) {
    Navigator.pop(context, true);
  }
}
