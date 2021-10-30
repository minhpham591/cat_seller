
import 'package:catapp/otherSelling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
String name="";
String phone="";
String price="";
String description="";
class CatDetail extends StatelessWidget {
  CatDetail(String _name,String _phone,String _price,String _description){
    name=_name;
    phone=_phone;
    price=_price;
    description=_description;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết về ${name}',style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontFamily: "DancingScript"),),
        centerTitle: true,),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepOrange, Colors.orangeAccent]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 500.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "$name",
                        style: TextStyle(
                          fontSize: 75.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 100.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: [
                             
                              Expanded(
                                child: Row(

                                  children: [
                                    Text(
                                      "Giá:",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "$price",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giới thiệu:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("$description"
                      ,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
           SizedBox(
            height: 50.0,
          ),
          Text("Số Điện Thoại Người Bán: $phone"),
          SizedBox(
            height: 50.0,
          ),
          
          Container(
            width: 300.00,
            height: MediaQuery.of(context).size.height*0.1,
            child: RaisedButton(
                onPressed: ()=>launch("tel:$phone"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)
                ),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.orangeAccent,Colors.orange]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("Liên Hệ",
                      style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
                    ),
                  ),
                )
            ),
          ),
           Material(
                    elevation: 0,
                    color: Color.fromRGBO(238, 237, 237, 0),
                    child: MaterialButton(
                      height: 2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => otherSelling(phone)),
                        );
                      },
                      child: Text(
                        "Xem thêm những chiếc mèo mà người này đang bán!!!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}