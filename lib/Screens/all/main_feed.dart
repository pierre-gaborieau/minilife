import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';

import 'package:minilife/Data/data_feed.dart';

class MainFeed extends StatefulWidget {
  final Size size;
  const MainFeed({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  _MainFeedState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Addictions : " +
                              DataCommon.mainCharacter
                                  .numberOfAddiction()
                                  .toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text("Balance : " +
                              DataCommon.mainCharacter.balance.toString() +
                              " €")
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Happiness : " +
                              DataCommon.mainCharacter.happiness.toString() +
                              "%")
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: widget.size.height - 270,
              width: widget.size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200]),
              child: SingleChildScrollView(
                child: Text(DataFeed.dataFeed),
                reverse: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
