import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startup_namer/User.dart';
import 'package:startup_namer/tinderCard.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  // make a function or method to make users from database
  final user = User(
    name: 'Brad',
    age: 25,
    urlImage: 'https://i.ebayimg.com/images/g/3zIAAOSwfHViRvMu/s-l500.jpg',
  );

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade200,
              Colors.black,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  buildLogo(),
                  const SizedBox(height: 16),
                  Expanded(child: TinderCard(user: user)),
                  const SizedBox(height: 16),
                  buildButtons(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildLogo() => Row(
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: Colors.white,
            size: 36,
          ),
          const SizedBox(width: 4),
          Text(
            'Copper',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      );

  Widget buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.orange, Colors.white),
              backgroundColor: getColor(Colors.white, Colors.orange),
              side: getBorder(Colors.orange, Colors.white),
            ),
            child: Icon(Icons.clear, size: 46),
            onPressed: () {},
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.red, Colors.white),
              backgroundColor: getColor(Colors.white, Colors.red),
              side: getBorder(Colors.red, Colors.white),
            ),
            child: Icon(Icons.star, size: 40),
            onPressed: () {},
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.pink, Colors.white),
              backgroundColor: getColor(Colors.white, Colors.pink),
              side: getBorder(Colors.pink, Colors.white),
            ),
            child: Icon(Icons.favorite, size: 40),
            onPressed: () {},
          ),
        ],
      );

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed) {
    final getBorder = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.transparent);
      } else {
        return BorderSide(color: color, width: 2);
      }
    };

    return MaterialStateProperty.resolveWith(getBorder);
  }
}
