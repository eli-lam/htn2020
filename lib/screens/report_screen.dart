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
    return Scaffold(
        appBar: AppBar(title: Text('Weekly Report')),
        body: StreamBuilder<QuerySnapshot>(
          // define a StreamBuilder of type QuerySnapshot
          stream: collectionReference
              .snapshots(), // use snapshots() function on a CollectionReference
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return new Center(child: new CircularProgressIndicator());
            return new Center(
                child: new Container(
                    child: new Column(
                        children: snapshot.data.documents
                            .map((doc) => new Text(doc['emotion'] +
                                DateFormat.yMMMd()
                                    .format(doc['date'].toDate())))
                            .toList())));
          },
        ));
  }
}
