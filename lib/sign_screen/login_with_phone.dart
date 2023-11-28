import 'package:emai_pasword/sign_screen/verify_code.dart';
import 'package:emai_pasword/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNomber extends StatefulWidget {
  const LoginWithPhoneNomber({super.key});

  @override
  State<LoginWithPhoneNomber> createState() => _LoginWithPhoneNomberState();
}

class _LoginWithPhoneNomberState extends State<LoginWithPhoneNomber> {
  bool loadind = false;
  final PhoneNomberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with phone nomber'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: PhoneNomberController,
              decoration: InputDecoration(hintText: "+123 321 123"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    loadind = true;
                  });
                  auth.verifyPhoneNumber(
                      verificationCompleted: (_) {
                        setState(() {
                          loadind = false;
                        });
                      },
                      phoneNumber: PhoneNomberController.text,
                      verificationFailed: (e) {
                        setState(() {
                          loadind = false;
                        });
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => VerifyCode(
                                  verificationId: verificationId,
                                )));
                        setState(() {
                          loadind = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loadind = false;
                        });
                      });
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
