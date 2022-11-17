import 'package:flutter/material.dart';
import 'package:startup_namer/User.dart';
import 'package:startup_namer/swipePage.dart';
import 'dart:typed_data';
import 'dart:convert';

class TinderCard extends StatefulWidget {
  final User user;

  const TinderCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.user.urlImage),
              fit: BoxFit.cover,
              alignment: Alignment(-0.3, 0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.7, 1],
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Spacer(),
                  buildName(),
                  const SizedBox(height: 8),
                  buildStatus(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildName() => Row(
        children: [
          Text(
            widget.user.name,
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${widget.user.age}',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ],
      );

  Widget buildStatus() => Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            width: 12,
            height: 12,
          ),
          const SizedBox(width: 8),
          Text(
            'Recently Active',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      );
}
