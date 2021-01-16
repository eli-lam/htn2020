import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

CollectionReference collectionReference =
    Firestore.instance.collection('emotions');

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // define a StreamBuilder of type QuerySnapshot
      stream: collectionReference
          .snapshots(), // use snapshots() function on a CollectionReference
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: Text('Loading data from Firebase...'));
        return Column(
          children: <Widget>[
            Text(snapshot.data.documents[0]['name']),
            Text(snapshot.data.documents[0]['level'])
          ],
        );
      },
    );
  }
}
