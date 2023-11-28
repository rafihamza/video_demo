import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emai_pasword/utils/utils.dart';
import 'package:flutter/material.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  final postController = TextEditingController();
  bool loading = false;
  final Firestore = FirebaseFirestore.instance.collection("rafi");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("add Firestore Data"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back))),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: postController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      hintText: "what is in your mind ",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          String id =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          Firestore.doc().set({
                            "title": postController.text.toString(),
                            "id": id
                          }).then((value) {
                            setState(() {
                              loading = false;
                            });
                            Utils().toastMessage("post added");
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });
                        },
                        child: Text("Add")))
              ],
            ),
          ),
        ));
  }
}
