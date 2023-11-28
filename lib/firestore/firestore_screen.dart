import 'package:emai_pasword/firestore/add_firestore_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final editeContriller = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirestoreScreen"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("helo"),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFirestoreData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editeContriller.text = title;
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("update"),
            content: Container(
              child: TextField(
                controller: editeContriller,
                decoration: InputDecoration(hintText: "edite"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("update")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancal"))
            ],
          );
        });
  }
}
