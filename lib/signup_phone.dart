import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttet_firebase_projact/signup.dart';
import 'package:fluttet_firebase_projact/varification_phone.dart';

class SignUpWithPhoneNumber extends StatefulWidget {
  const SignUpWithPhoneNumber({super.key});

  @override
  State<SignUpWithPhoneNumber> createState() => _SignUpWithPhoneNumberState();
}

class _SignUpWithPhoneNumberState extends State<SignUpWithPhoneNumber> {
  TextEditingController phoneEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void varificationPhoneFuncation() {
    _auth.verifyPhoneNumber(
      phoneNumber: phoneEditingController.text,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException error) {
        print(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                VarificationPhone(varificationid: verificationId)));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print(verificationId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 4, 81, 145),
        title: const Text('LOGIN WITH PHONE',
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
                  controller: phoneEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email),
                      hintText: '+92 309 8620 617',
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
                    onPressed: () {
                      varificationPhoneFuncation();
                    },
                    child: const Text(
                      'Login with Phone',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
