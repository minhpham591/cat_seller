import 'package:flutter/material.dart';

String phone = "";

class Home extends StatefulWidget {
  Home(String _phone) {
    phone = _phone;
  }
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.all(1.0),
        // padding: const EdgeInsets.all(1.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              child: Text(
                'Chào mừng $phone',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    "assets/images/home.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
             Container(
              height: 100,
            ),
            Container(
              height: 50,
              child: Text(
                'ĐÃ ĐẾN VỚI "HOOMAN CHOICE"',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              child: Text(
                '* ĐỂ BÁN "QUÀNG THƯỢNG" CỦA BẠN HÃY ẤN "TẠO"',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              child: Text(
                '* ĐỂ MUA "QUÀNG THƯỢNG" HÃY ẤN "MÈO ĐỂ BÁN"',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
