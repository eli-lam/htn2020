import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

CollectionReference collectionReference =
    Firestore.instance.collection('emotions');

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(117, 119, 151, .1),
      100: Color.fromRGBO(117, 119, 151, .2),
      200: Color.fromRGBO(117, 119, 151, .3),
      300: Color.fromRGBO(117, 119, 151, .4),
      400: Color.fromRGBO(117, 119, 151, .5),
      500: Color.fromRGBO(117, 119, 151, .6),
      600: Color.fromRGBO(117, 119, 151, .7),
      700: Color.fromRGBO(117, 119, 151, .8),
      800: Color.fromRGBO(117, 119, 151, .9),
      900: Color.fromRGBO(117, 119, 151, 1),
    };
    return Scaffold(
        appBar: AppBar(
            title: Text('Weekly Report'),
            backgroundColor: MaterialColor(0xFF757797, color)),
        body: StreamBuilder<QuerySnapshot>(
          // define a StreamBuilder of type QuerySnapshot
          stream: collectionReference
              .snapshots(), // use snapshots() function on a CollectionReference
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return new Center(child: new CircularProgressIndicator());
            List<Column> loWidg = [];
            snapshot.data.documents.forEach((doc) => {
                  loWidg.add(Column(children: [
                    Column(children: <Widget>[
                      Text(doc['emotion']),
                      Text(DateFormat.yMMMd().format(doc['date'].toDate()))
                    ])
                  ]))
                });
            snapshot.data.documents.asMap().forEach((k, doc) => {
                  loWidg[k].children.add(Image.asset(
                      'assets/' + doc['emotion'] + '.png',
                      height: 50,
                      width: 50))
                });
            return new Center(
              child: new Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                height: MediaQuery.of(context).size.height * 0.17,
                child: ListView(
                    scrollDirection: Axis.horizontal, children: loWidg),
              ),
            );
          },
        ));
  }
}
