import 'package:flutter/material.dart';
import 'package:mood_tracker/config/palette.dart';

class PastWeekCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: MediaQuery.of(context).size.height * 0.17,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildDailyCard('assets/Happy.png', '17', context),
          _buildDailyCard('assets/Happy.png', '16', context),
          _buildDailyCard('assets/Happy.png', '15', context),
          _buildDailyCard('assets/Happy.png', '14', context),
          _buildDailyCard('assets/Happy.png', '13', context),
          _buildDailyCard('assets/Happy.png', '12', context),
          _buildDailyCard('assets/Happy.png', '11', context),
        ],
      ),
    );
  }

  Container _buildDailyCard(
      String imageVal, String date, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.23,
      child: Card(
        color: Palette.secondaryColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Wrap(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                imageVal,
                width: MediaQuery.of(context).size.width * 0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
