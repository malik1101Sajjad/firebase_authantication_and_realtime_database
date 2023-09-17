import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttet_firebase_projact/my_home.dart';
import 'package:fluttet_firebase_projact/signup_phone.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController gmailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    gmailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  void signeUpFunction() {
    _auth
        .createUserWithEmailAndPassword(
            email: gmailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.toString())
        .then((value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MyHome())));
  }

  void loginFuncation() {
    _auth
        .signInWithEmailAndPassword(
            email: gmailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.toString())
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyHome())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 4, 81, 145),
        title: const Text('SIGNUP & LOGIN  WITH GMAIL AND PHONE',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              ContainerWiget(
                child: TextFormField(
                    controller: gmailTextEditingController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter Gmail',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w100))),
              ),
              const SizedBox(height: 10),
              ContainerWiget(
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordTextEditingController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w100))),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 7, 74, 129),
                          foregroundColor:
                              const Color.fromRGBO(255, 235, 59, 1)),
                      onPressed: () {
                        signeUpFunction();
                      },
                      child: const Text('Sign Up'))),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 7, 74, 129),
                          foregroundColor:
                              const Color.fromRGBO(255, 235, 59, 1)),
                      onPressed: () {
                        loginFuncation();
                      },
                      child: const Text('Login'))),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 7, 74, 129),
                          foregroundColor:
                              const Color.fromRGBO(255, 235, 59, 1)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const SignUpWithPhoneNumber()));
                      },
                      child: const Text('Login with Phone')))
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerWiget extends Container {
  ContainerWiget({required this.child, super.key})
      : super(
            padding: const EdgeInsets.all(5),
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 3,
                      offset: const Offset(-5, -5)),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                      offset: const Offset(5, 5))
                ]));
  final Widget child;
}
