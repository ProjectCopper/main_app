// this needs to be modified to create one user after the other
import 'package:flutter/cupertino.dart';
import 'package:startup_namer/swipePage.dart';
import 'package:startup_namer/tinderCard.dart';
import 'package:flutter/services.dart';

class User {
  final String name;
  final int age;
  final String urlImage;

  const User({
    required this.name,
    required this.age,
    required this.urlImage,
  });
}
