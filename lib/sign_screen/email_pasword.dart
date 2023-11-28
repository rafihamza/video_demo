import 'package:emai_pasword/sign_screen/sign_up.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          height: 50,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.visibility_off_outlined),
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
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text("Login")),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Dont Have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignUpPage()));
                      },
                      child: Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
