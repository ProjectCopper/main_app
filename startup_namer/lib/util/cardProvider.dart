import 'dart:math';

import 'package:flutter/material.dart';
import 'package:startup_namer/util/User.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<User> get users => _users;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus(force: true);

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  double getStatusOpacity() {
    final delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;

    if (force) {
      final delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta / 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      final delta = 20;

      if (y <= -delta * 2 && forceSuperLike) {
        return CardStatus.superLike;
      } else if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      }
    }
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void superLike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if (users.isEmpty) return;

    await Future.delayed(Duration(milliseconds: 200));
    _users.removeLast();
    resetPosition();
  }

  void resetUsers() {
    _users = <User>[
      User(
        name: 'Brad',
        age: 25,
        urlImage: 'https://i.ebayimg.com/images/g/3zIAAOSwfHViRvMu/s-l500.jpg',
      ),
      User(
        name: 'MJ',
        age: 23,
        urlImage:
            'https://i.pinimg.com/originals/bb/49/38/bb4938b2e03b9445348ff5c0c8fb65eb.jpg',
      ),
      User(
        name: 'Jonny',
        age: 27,
        urlImage:
            'https://i.pinimg.com/474x/79/f6/63/79f6635537bc70f0340487efdf7135bc--jared-leto-young-young-johnny-depp.jpg',
      ),
      User(
        name: 'Ben',
        age: 25,
        urlImage:
            'https://www.wonderwall.com/wp-content/uploads/sites/2/2019/03/1049956-pearl-harbor-2001.jpg',
      ),
      User(
        name: 'Richard',
        age: 28,
        urlImage:
            'https://i.pinimg.com/originals/f5/0b/58/f50b58bd20cef854d6dc2d7f24bc567c.jpg',
      ),
      User(
        name: 'Leo',
        age: 25,
        urlImage:
            'https://cdn.fansshare.com/photos/leonardodicaprio/leonardo-dicaprio-leonardo-dicaprio-young-472853757.jpg',
      ),
    ].reversed.toList();

    notifyListeners();
  }
}
