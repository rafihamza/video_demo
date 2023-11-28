import 'package:emai_pasword/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("add post"),
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
                          databaseRef.child(id).child("rafi").set({
                            "title": postController.text.toString(),
                            "id": id,
                          }).then((value) {
                            Utils().toastMessage("post Added");
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
                        child: Text("Add")))
              ],
            ),
          ),
        ));
  }
}
