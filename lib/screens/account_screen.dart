import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//final databaseReference = Firestore.instance;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RaisedButton(
            child: Text('Read data from Firestore'),
            onPressed: () {
              //getData();
            }));
  }
}
