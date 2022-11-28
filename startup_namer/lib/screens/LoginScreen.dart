import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/util/cardProvider.dart';
import 'package:startup_namer/util/tinderCard.dart';
import 'HomePage.dart';
import 'newAccount.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final String title = 'Copper';

  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;
  bool loginError = false;

  //UserProvider _userProvider;

  void initState() {
    super.initState();
    //_userProvider = Provider.of(context, listen: false);
  }

  static Future<User?> loginPressed({
    required String email,
    required String password,
    // required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  // void loginPressed() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _inputEmail, password: _inputPassword);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  //   Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                    width: 100,
                    height: 120,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/copperIcon.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/copperLogo2.0.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email address'),
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _inputEmail = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) => _inputPassword = value,
              ),
            ),
            if (loginError)
              Text("Incorrect Email or Password",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => newAccount()));
              },
              child: Text(
                'Create Account',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.deepOrange[200],
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  User? user = await loginPressed(
                      email: _inputEmail, password: _inputPassword);
                  if (user != null) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User?'),
            TextButton(
              onPressed: () {},
              child: Text(
                'Create Account',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
