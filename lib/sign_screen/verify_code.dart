import 'package:emai_pasword/post_screen/post_screen.dart';
import 'package:emai_pasword/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify code'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: verificationCodeController,
              decoration: const InputDecoration(hintText: "6 digit code"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString());
                  try {
                    await auth.signInWithCredential(crendital);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                },
                child: Text("verify"))
          ],
        ),
      ),
    );
  }
}
