
import 'package:catapp/enterOTP.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String phone="";
  String verificationId="";
  String errorMessage = '';
  RegExp regexPhone = new RegExp(r'(^(?:[+0]9)?[0-9]{10,10}$)');
  _verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (verficationID, resendToken) {
          verificationId = verficationID;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EnterOTP(phone, verificationId)),
            ModalRoute.withName('/'),
          );
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // set up the AlertDialog

  @override
  Widget build(BuildContext context) {
    final phoneField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please enter Phone number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (value) {
        value = value;
        if (value.toString().isEmpty) {
          return 'Please enter phone number';
        } else if (!regexPhone.hasMatch(value.toString())) {
          return 'Phone number is not correct';
        } else {
          phone = "+84" + value.toString().substring(1);
        }
        return null;
      },
    );
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
          } else {
            //showAlertPhoneSuccess(context);
            print(phone);
            _verifyPhone(phone);
          }
        },
        child: Text(
          "Sign In",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
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
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(child: Text('HOOMAN CHOICE', style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
                height: 3,
              ),
              textAlign: TextAlign.center,),),
                  phoneField,
                  SizedBox(height: 15),
                  nextButton,
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
