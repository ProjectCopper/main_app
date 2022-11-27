import 'package:startup_namer/util/messageConstants.dart';
import 'package:startup_namer/util/chatMessage.dart';
import 'package:flutter/material.dart';

import 'messageInput.dart';
import 'messageMain.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
