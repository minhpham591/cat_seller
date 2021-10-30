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
      stream: cat.where('numberphone', isNotEqualTo: phone).snapshots(),
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
              title:  Container(
                margin: const EdgeInsets.all(1.0),
                      padding: const EdgeInsets.all(1.0),
                      width: MediaQuery.of(context).size.width,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(4, 8), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            new Text(document.data()['name']),
                            new SizedBox(width: MediaQuery.of(context).size.width*0.4,),
                            new Text(document.data()['price'])
                          ],),
              ),
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
