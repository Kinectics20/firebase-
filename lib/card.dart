import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = new DateTime.fromMillisecondsSinceEpoch(
        snapshot.docs[index]['timestamp'].seconds * 1000);
    var dateformatted = new DateFormat('dd-MM-yyyy').format(time);
    return Container(
      height: 150,
      child: Card(
        elevation: 9.0,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 34,
                child: Text(snapshot.docs[index].get('name').toString()[0]),
              ),
              subtitle: Text(snapshot.docs[index].get('description')),
              title: Text(snapshot.docs[index].get('name')),
            ),
            Text((dateformatted))
          ],
        ),
      ),
    );
  }
}
