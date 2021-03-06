
import 'package:catapp/detailCat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream collectionStream = FirebaseFirestore.instance.collection('catForSell').snapshots(includeMetadataChanges: true);
String phone="";
class otherSelling extends StatelessWidget {
  otherSelling(String _phone){
    phone=_phone;
  }
  @override
  Widget build(BuildContext context) {
   CollectionReference cat =FirebaseFirestore.instance.collection('catForSell');
   return Scaffold(
   appBar: AppBar(title: Text('Mèo cần bán của ${phone}',style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontFamily: "DancingScript"),),
        centerTitle: true,),
    body: StreamBuilder<QuerySnapshot>(
      
      stream: cat.where('numberphone', isEqualTo: phone).snapshots(),
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
                      height: MediaQuery.of(context).size.height*0.1,
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
                          child: Column(
                            children: [
                            new Text('Chủng loại: ${document.data()["name"]}', style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, fontSize: 20) ),
                            new SizedBox(height: MediaQuery.of(context).size.height*0.05),
                            new Text('Giá: ${document.data()["price"]}', style: TextStyle(color: Colors.redAccent, fontStyle: FontStyle.italic))
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
    ),);
  }
}