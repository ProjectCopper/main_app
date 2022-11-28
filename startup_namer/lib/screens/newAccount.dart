import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/util/cardProvider.dart';
import 'package:startup_namer/util/tinderCard.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';

class newAccount extends StatefulWidget {
  static const String id = 'newAccount';

  @override
  _NewAccountState createState() => _NewAccountState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _NewAccountState extends State<newAccount> {
  static final String title = 'Copper';
  String _inputName = '';
  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;

  static Future<User?> createAccountPressed({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      print(user);
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      print(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.navigate_before),
                color: Colors.deepOrange.shade200,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
              ),
            ),
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
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Welcome To Copper",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange)))),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preferred Name',
                    hintText: 'Enter your preferred name'),
                obscureText: false,
                keyboardType: TextInputType.text,
                onChanged: (value) => _inputName = value,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'New Account Email/Phone Number',
                    hintText: 'Enter valid email or phone number'),
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
                    labelText: 'New Account Password',
                    hintText: 'Enter password'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _inputPassword = value,
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.deepOrange[200],
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  User? user = await createAccountPressed(
                      name: _inputName,
                      email: _inputEmail,
                      password: _inputPassword);
                  if (user != null) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
