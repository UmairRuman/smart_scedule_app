import 'package:flutter/material.dart';
import 'package:smart_club_app/pages/bulbs_page/view/bulb_page.dart';
import 'package:smart_club_app/pages/fan_page/view/fan_page.dart';

Widget buildIotControls(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const BulbPage(),
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: const Color.fromARGB(255, 26, 42, 38), size: 30),
              SizedBox(height: 5),
              Text('Lights', style: TextStyle(color: Colors.white)),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FansPage(),
              ));
            },
            child: Column(
              children: [
                Icon(Icons.wb_sunny, color: Colors.tealAccent, size: 30),
                SizedBox(height: 5),
                Text('Fans', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
