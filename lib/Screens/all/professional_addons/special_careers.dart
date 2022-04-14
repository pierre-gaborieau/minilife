import 'package:flutter/material.dart';

class SpecialCareers extends StatelessWidget {
  const SpecialCareers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.music_note_rounded),
          title: const Text("Music Carreer"),
          onTap: () => _navigateToMusicCarreer(context),
        ),
      ]),
    );
  }

  _navigateToMusicCarreer(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/musicCarreer");

    if (translate == true) {
      Navigator.pop(context, true);
    }
  }
}
