import 'package:flutter/material.dart';
import 'package:mood_tracker/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PastWeekCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: MediaQuery.of(context).size.height * 0.17,
      child: getDataFromDatabase(),
    );
  }

  CollectionReference collectionReference =
      Firestore.instance.collection('emotions');

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

  Widget getDataFromDatabase() {
    List<Widget> loWidg = [];
    return StreamBuilder<QuerySnapshot>(
        // define a StreamBuilder of type QuerySnapshot
        stream: collectionReference
            .snapshots(), // use snapshots() function on a CollectionReference
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Center(child: new CircularProgressIndicator());
          snapshot.data.documents.forEach((doc) => {
                loWidg.add(_buildDailyCard('assets/' + doc['emotion'] + '.png',
                    DateFormat.d().format(doc['date'].toDate()), context))
              });
          return ListView(
            scrollDirection: Axis.horizontal,
            children: loWidg,
          );
        });
  }
}
