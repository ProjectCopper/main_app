import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/util/cardProvider.dart';
import 'package:startup_namer/util/tinderCard.dart';
import 'screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Copper';
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: LoginScreen(),
          theme: ThemeData(
            primarySwatch: Colors.grey,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 32),
                elevation: 8,
                primary: Colors.white,
                shape: CircleBorder(),
                minimumSize: Size.square(80),
              ),
            ),
          ),
        ),
      );
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// void loginPressed() async {
//   setState(() {
//     _isLoading = true;
//   });
//   await _userProvider
//       .loginUser(_inputEmail, _inputPassword, _scaffoldKey)
//       .then((response) {
//     if (response is Success<UserCredential>) {
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil(TopNavigationScreen.id, (route) => false);
//     }
//   });
//   setState(() {
//     _isLoading = false;
//   });
// }

class _LoginScreenState extends State<LoginScreen> {
  @override
  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;

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
                    labelText: 'Email/Phone Number',
                    hintText: 'Enter valid email or phone number'),
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (value) => _inputPassword = value,
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
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _inputEmail = value,
              ),
            ),
            TextButton(
              onPressed: () {},
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
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
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
