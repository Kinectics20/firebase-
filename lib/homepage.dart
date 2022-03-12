import 'package:firebase_app/card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
//creating the database for the app through firestore
  var clone = FirebaseFirestore.instance.collection('meeting').snapshots();
  TextEditingController name = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Scaffold(
        appBar: AppBar(
          title:
              Text('PLATFORM', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAlert(context);
          },
          child: Icon(FontAwesomeIcons.pen),
        ),
        body: StreamBuilder(
            stream: clone,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    //  return Text(snapshot.data!.docs[index]['description']);
                    return CustomCard(snapshot:snapshot.data,index:index);
                  });
            }));
  }

  // showDialog(BuildContext context) async {
  //  await showDialog(context: context, builder: (context) => AlertDialog());
  // }

  void showAlert(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: Column(children: [
                Text('PLEASE FILL THIS FORM'),
                Expanded(
                    child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'NAME',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.person),
                      hintText: 'name'),
                  controller: name,
                )),
                Expanded(
                    child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'title'),
                  controller: title,
                )),
                Expanded(
                    child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'description'),
                  controller: description,
                ))
              ]),
              actions: [
                GestureDetector(
                    onTap: () {
                      name.clear();
                      description.clear();
                      title.clear();
                      Navigator.pop(context);
                    },
                    child: Text('cancel')),
                GestureDetector(
                  onTap: () {
                    if (name.text.isNotEmpty &&
                        description.text.isNotEmpty &&
                        title.text.isNotEmpty) {
                      FirebaseFirestore.instance.collection("meeting").add({
                        "name": name.text,
                        "title": title.text,
                        "description": description.text,
                        "timestamp": new DateTime.now()
                      }).then((response) {
                        print(response.id);
                        Navigator.pop(context);
                        name.clear();
                        description.clear();
                        title.clear();
                        // ignore: invalid_return_type_for_catch_error
                      }).catchError((error) => print(error));
                    }
                  },
                  child: Text(
                    'save',
                  ),
                )
              ],
            ));
  }
}
