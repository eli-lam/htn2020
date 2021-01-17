import 'package:flutter/material.dart';

class Top5Keywords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              _buildKeywordCard('So much work'),
              _buildKeywordCard('Headache'),
              _buildKeywordCard('Tired'),
              _buildKeywordCard('Sleep deprived'),
              _buildKeywordCard('Hungry'),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildKeywordCard(String keywords) {
    return Container(
      child: UnconstrainedBox(
        child: Card(
          color: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF4D77EA)),
            borderRadius: BorderRadius.only(
              topLeft: new Radius.circular(15.0),
              topRight: new Radius.circular(15.0),
              bottomRight: new Radius.circular(15.0),
              //bottomLeft: new Radius.circular(20.0),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: Text(
                keywords,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
