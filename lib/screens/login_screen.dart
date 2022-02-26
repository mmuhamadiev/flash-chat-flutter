import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/Components/navigation_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final messageTextController = TextEditingController();
  final messagePasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: messageTextController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your email',hintStyle: TextStyle(color: Colors.black54))
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: messagePasswordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your password',hintStyle: TextStyle(color: Colors.black54))
              ),
              SizedBox(
                height: 24.0,
              ),
              NavigationButton(onPressButton: () async {
                //print(email);
                //print(password);
                setState(() {
                  showSpinner = true;
                });
                try {
                  final existUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(existUser != null) {
                    print(existUser);
                    Navigator.pushNamed(context, '/chat');
                  }
                  setState(() {
                    showSpinner = false;
                  });
                }
                catch(e) {
                  print(e);
                  setState(() {
                    showSpinner = false;
                  });
                  messageTextController.clear();
                  messagePasswordController.clear();
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Input Error'),
                      content: Text(e.toString()),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              }, text: 'Log In', colour: Colors.lightBlueAccent)
            ],
          ),
        ),
      ),
    );
  }
}
