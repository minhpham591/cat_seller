import 'package:flutter/material.dart';
import 'package:catapp/home.dart';
import 'package:catapp/create.dart';
import 'package:catapp/catSelling.dart';
/// This is the stateful widget that the main application instantiates.
 String phone="";
class Menu extends StatefulWidget {
  
  Menu(String _phone){
    phone =_phone;
  }
  @override
  State<Menu> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Menu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    
    Home(phone),

   Create(phone),
   
    catSelling(phone),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOOMAN CHOICE',style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tạo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Mèo để bán',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}