import 'package:emai_pasword/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firestore/firestore_screen.dart';
import 'login_with_phone.dart';

class SignUpPage extends StatefulWidget {
  final bool loading;

  SignUpPage({
    super.key,
    this.loading = false,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void SignUP() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => FirestoreScreen()));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(hintText: "Firs tName"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Last Name"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email),
                                hintText: "Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                hintText: "Password"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password";
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUP();
                      setState(() {
                        loading = true;
                      });
                    }
                    _auth
                        .createUserWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) {
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          strokeWidth: 4,
                          color: Colors.white,
                        )
                      : Text(
                          "Sign Up",
                        ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("already Have an account"),
                    TextButton(onPressed: () {}, child: Text("Login"))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => LoginWithPhoneNomber()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                      child: Text("Login with phone"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
