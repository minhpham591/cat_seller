import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:catapp/model/cat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
String phone="";
String name = "";

String price = "";
String description = "";
AddNew _addNew= new AddNew(name, price, phone, description);

class NewCreate extends StatefulWidget {
  NewCreate(String _phone) {
    phone = _phone;
  }
  @override
  _NewCreate createState() => _NewCreate();
}
showAlertSuccessUpdate(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      color: Colors.orangeAccent,
      onPressed: () {
        Navigator.of(context).pop();
        
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Tạo tin thành công"),
      content: Text("Hãy chờ người mua liên lạc nhé"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
CollectionReference cat = FirebaseFirestore.instance.collection('catForSell');
Future<void> addNew(AddNew addNew, BuildContext context) async{
  
    //String url="https://617b8b0fd842cf001711bf24.mockapi.io/api/CatForSell";
    // var body = json.encode(addNew.toJson());
    // print(body);
    //final response = await http.post(url,body: body);
    // print(response.statusCode);
    // if(response.statusCode==201){
    //   showAlertSuccessUpdate(context);
    // }
    // else{
    //   throw Exception('Failed to load data');
    // }
    return cat.add(addNew.toJson()).then((value) => showAlertSuccessUpdate(context)).catchError((error)=>throw Exception('Failed to load data'));
}
class _NewCreate extends State<NewCreate> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nextButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.orangeAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
           if (!formKey.currentState!.validate()) {
            return;
          } else{
          _addNew.numberPhone = phone;
          _addNew.name = name;
          _addNew.price=price;
          _addNew.description=description;
          addNew(_addNew, context);
          
          }
        },
        child: Text(
          "Đăng tin",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Forgot Password"),
      //   backgroundColor: Colors.blue[900],
      // ),
      body: Center(
        child: Container(
          color: Color.fromRGBO(238, 237, 237, 0.5),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    width: 500,
                    child: Image.asset(
                      "assets/images/new.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: style,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Tên",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      value = value;
                      if (value.toString().isEmpty) {
                        return 'Tên không được bỏ trống';
                       }else {
                        name = value.toString();
                        _addNew.name = value.toString();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: style,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Giá",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    validator: (value) {
                      value = value;
                      if (value.toString().isEmpty) {
                        return 'Giá không được bỏ trống';
                      } else {
                        price = value.toString();
                        _addNew.price=value.toString();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: style,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Chi Tiết",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    validator: (value) {
                      value = value;
                      if (value.toString().isEmpty) {
                        return 'Chi tiết không được bỏ trống';
                      } else {
                        description = value.toString();
                        _addNew.description=value.toString();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  nextButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
