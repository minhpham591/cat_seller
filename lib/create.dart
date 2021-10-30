
import 'package:flutter/material.dart';
import 'package:catapp/createNew.dart';
import 'package:catapp/mySelling.dart';
String phone = "";

class Create extends StatefulWidget {
  Create(String _phone) {
    phone = _phone;
  }

  @override
  _Create createState() => _Create();
}

TextStyle style = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);

class _Create extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Đăng bán',
                  style: style,
                ),
              ),
              Tab(
                child: Text(
                  'Đã đăng',
                  style: style,
                ),
              ),
            ],
            indicatorWeight: 2,
            indicatorPadding: EdgeInsets.all(10.0),
            indicatorColor: Colors.deepOrange,
          ),
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          children: [
            NewCreate(phone),
            mySelling(phone),
          ],
        ),
      ),
    );
  }
}
