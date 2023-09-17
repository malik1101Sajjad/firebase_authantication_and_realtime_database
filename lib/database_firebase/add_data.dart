import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController discripationEditingController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 81, 145),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('DATA DATA',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    maxLines: 4,
                    controller: discripationEditingController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Discripation',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w100))),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 4, 81, 145),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        databaseRef.child(id).set({
                          'Discripation':
                              discripationEditingController.text.toString(),
                          'id': id
                        });
                      },
                      child: const Text(
                        'ADD DATA',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
