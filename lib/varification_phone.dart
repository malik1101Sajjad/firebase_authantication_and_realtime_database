import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttet_firebase_projact/my_home.dart';
import 'package:fluttet_firebase_projact/signup.dart';

// ignore: must_be_immutable
class VarificationPhone extends StatefulWidget {
  String varificationid;
  VarificationPhone({required this.varificationid, super.key});

  @override
  State<VarificationPhone> createState() => _VarificationPhoneState();
}

class _VarificationPhoneState extends State<VarificationPhone> {
  TextEditingController codeEditingController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 4, 81, 145),
        title: const Text('VERIFICATION CODE',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            ContainerWiget(
              child: TextFormField(
                  controller: codeEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email),
                      hintText: '6 digit code',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w100))),
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 74, 129),
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      final craditional = PhoneAuthProvider.credential(
                          verificationId: widget.varificationid,
                          smsCode: codeEditingController.text.toString());
                      await auth.signInWithCredential(craditional).then(
                          (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHome())));
                    },
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
