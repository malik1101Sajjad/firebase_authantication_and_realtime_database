import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttet_firebase_projact/database_firebase/add_data.dart';
import 'package:fluttet_firebase_projact/signup.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 4, 81, 145),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('FIREBASE DATABASE',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    auth.signOut().then((value) => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SignUp())));
                  },
                  leading: const Icon(
                    Icons.logout,
                    size: 15,
                  ),
                  title: const Text(
                    'LogOut',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ))
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 50, top: 5, bottom: 20),
            child: TextFormField(
              controller: searchEditingController,
              decoration: const InputDecoration(hintText: 'search'),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              final discripation =
                  snapshot.child('Discripation').value.toString();
              final id = snapshot.child('id').value.toString();
              if (searchEditingController.text.isEmpty) {
                return ListTile(
                  title: Text(snapshot.child('Discripation').value.toString(),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold)),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showMyDilog(discripation, id);
                          },
                          leading: const Icon(Icons.edit, size: 15),
                          title: const Text('Edit',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        )),
                        PopupMenuItem(
                            child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ref.child(id).remove();
                          },
                          leading: const Icon(Icons.delete, size: 15),
                          title: const Text('Delete',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ))
                      ];
                    },
                  ),
                );
              } else if (discripation.toLowerCase().contains(
                  searchEditingController.text.toLowerCase().toLowerCase())) {
                return ListTile(
                    title: Text(snapshot.child('Discripation').value.toString(),
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)));
              } else {
                return Container();
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 4, 81, 145),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddData()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDilog(String discriptaion, String id) async {
    TextEditingController updateEditingController = TextEditingController();
    updateEditingController.text = discriptaion;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextFormField(
                maxLines: 3,
                controller: updateEditingController,
                decoration: const InputDecoration(
                    hintText: 'Discripation', border: InputBorder.none),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    ref.child(id).update({
                      'Discripation': updateEditingController.text.toString(),
                      'id': id
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
            ],
          );
        });
  }
}
