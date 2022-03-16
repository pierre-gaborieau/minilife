import 'package:flutter/material.dart';

class ProfessionalScreen extends StatelessWidget {
  const ProfessionalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: const [
        ListTile(
          leading: Icon(Icons.menu_book_rounded),
          title: Text("Education"),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.wallet_travel),
          title: Text("Jobs"),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.star_border_outlined),
          title: Text("Special Career"),
          onTap: null,
        )
      ],
    ));
  }
}
