import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:catapp/detailCat.dart';

Stream collectionStream = FirebaseFirestore.instance
    .collection('catForSell')
    .snapshots(includeMetadataChanges: true);
String phone = "";

class catSelling extends StatelessWidget {
  catSelling(String _phone) {
    phone = _phone;
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference cat =
        FirebaseFirestore.instance.collection('catForSell');

    return StreamBuilder<QuerySnapshot>(
      stream: cat.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['name']),
              subtitle: new Text(document.data()['price']),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CatDetail(
                          document.data()['name'],
                          document.data()['numberphone'],
                          document.data()['price'],
                          document.data()['description']))),
            );
          }).toList(),
        );
      },
    );
  }
}
