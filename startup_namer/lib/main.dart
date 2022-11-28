import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/util/cardProvider.dart';
import 'package:startup_namer/util/tinderCard.dart';
import 'screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Copper",
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
