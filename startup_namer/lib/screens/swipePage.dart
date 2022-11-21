import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startup_namer/util/User.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/screens/HomePage.dart';
import 'package:startup_namer/util/tinderCard.dart';
import 'package:startup_namer/util/cardProvider.dart';
//import 'package:startup_namer/util/cardProviderTop.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  // make a function or method to make users from database

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.navigate_before),
                        color: Colors.deepOrange.shade200,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomePage()));
                        },
                      ),
                      const SizedBox(width: 46),
                      Icon(
                        Icons.tapas_outlined,
                        color: Colors.deepOrange.shade200,
                        size: 36,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Copper',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange.shade200,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(height: 200, width: 200, child: buildTopCards()),
                  const SizedBox(height: 20),
                  buildButtons(),
                  const SizedBox(height: 20),
                  SizedBox(height: 200, width: 200, child: buildBottomCards()),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildBottomCards() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;

    return users.isEmpty
        ? Center(
            child: Text(
              '💔  The End.',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        : Stack(
            children: users
                .map((user) => TinderCard(
                      user: user,
                      isFront: users.last == user,
                    ))
                .toList(),
          );
  }

  Widget buildTopCards() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;

    return users.isEmpty
        ? Center(
            child: Text(
              '💔  The End.',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        : Stack(
            children: users
                .map((user) => TinderCard(
                      user: user,
                      isFront: users.last == user,
                    ))
                .toList(),
          );
  }

  Widget buildLogo() => Row(
        children: [
          Icon(
            Icons.tapas_outlined,
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

  Widget buildButtons() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    //final isLikeB = status == CardStatusB.like;
    final isDislikeT = status == CardStatus.dislike;
    //final isDislikeB = status == CardStatusB.dislike;

    return users.isEmpty
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Restart',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // final providertop =
              //    Provider.of<CardProviderTop>(context, listen: false);
              final providerbottom =
                  Provider.of<CardProvider>(context, listen: false);

              //providertop.resetUsers();
              providerbottom.resetUsers();
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      getColor(Colors.orange, Colors.white, isDislikeT),
                  backgroundColor:
                      getColor(Colors.white, Colors.orange, isDislikeT),
                  side: getBorder(Colors.orange, Colors.white, isDislikeT),
                ),
                child: Icon(Icons.clear, size: 46),
                onPressed: () {
                  //final providertop =
                  //    Provider.of<CardProviderTop>(context, listen: false);
                  final providerbottom =
                      Provider.of<CardProvider>(context, listen: false);

                  // providertop.dislike();
                  providerbottom.dislike();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: getColor(Colors.red, Colors.white, isLike),
                  backgroundColor: getColor(Colors.white, Colors.red, isLike),
                  side: getBorder(Colors.red, Colors.white, isLike),
                ),
                child: Icon(Icons.arrow_upward_outlined, size: 40),
                onPressed: () {
                  // final provider =
                  //    Provider.of<CardProviderTop>(context, listen: false);

                  // provider.like();
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: getColor(Colors.pink, Colors.white, isLike),
                  backgroundColor: getColor(Colors.white, Colors.pink, isLike),
                  side: getBorder(Colors.pink, Colors.white, isLike),
                ),
                child: Icon(Icons.arrow_downward_outlined, size: 40),
                onPressed: () {
                  final provider =
                      Provider.of<CardProvider>(context, listen: false);

                  provider.like();
                },
              ),
            ],
          );
  }

  MaterialStateProperty<Color> getColor(
      Color color, Color colorPressed, bool force) {
    final getColor = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(
      Color color, Color colorPressed, bool force) {
    final getBorder = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.transparent);
      } else {
        return BorderSide(color: color, width: 2);
      }
    };

    return MaterialStateProperty.resolveWith(getBorder);
  }
}
