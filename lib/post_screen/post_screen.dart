import 'package:emai_pasword/post_screen/add_post_screen.dart';
import 'package:emai_pasword/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final searchFilter = TextEditingController();
  final editeContriller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("post");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("postScreen"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                  hintText: "search", border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child("title").value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(snapshot
                                            .child("id")
                                            .value
                                            .toString())
                                        .remove();
                                    showMyDialog(title,
                                        snapshot.child("id").value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text("edit"),
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(snapshot
                                            .child("id")
                                            .value
                                            .toString())
                                        .remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("delete"),
                                ))
                          ],
                        ));
                  } else if (title.toLowerCase().contains(
                      searchFilter.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else {
                    return ClipRRect();
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
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
                    ref.child(id).update({
                      'title': editeContriller.text.toLowerCase()
                    }).then((value) {
                      Utils().toastMessage("post update");
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("cancal"))
            ],
          );
        });
  }
}
