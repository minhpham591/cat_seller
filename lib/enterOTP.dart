import 'package:catapp/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class EnterOTP extends StatelessWidget {
  String phone = "";
  String verificationId = "";
  EnterOTP(String _phone, String _vertificationId) {
    phone = _phone;
    verificationId = _vertificationId;
  }
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20);
  String pin = "";
  RegExp regexPin = new RegExp(r'(^(?:[+0]9)?[0-9]{6,6}$)');
  _verifyPhone(BuildContext context, String phone, String verificationId,
      int countResend) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (verficationID, resendToken) {
          verificationId = verficationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        timeout: Duration(seconds: 120));
  }

  @override
  Widget build(BuildContext context) {
    final OTPtextField = OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 50,
      style: TextStyle(fontSize: 14),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onCompleted: (value) {
        pin = value;
      },
      onChanged: (value) {
        pin = value;
      },
    );
    final nextButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          try {
            FirebaseAuth.instance
                .signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: pin))
                .then((value) async {
              if (value.user != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Menu(phone)),
                    (route) => false);
              }
            });
          } catch (FirebaseAuthException) {
            _showToast(context);
          }
        },
        child: Text(
          "Verify",
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Input your OTP",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    fontSize: 40,
                      color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                OTPtextField,
                SizedBox(height: 25),
                nextButton,
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 45),
        content: const Text('OTP is wrong!!!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        action: SnackBarAction(
            label: "",
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
