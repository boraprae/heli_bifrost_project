import 'package:flutter/material.dart';
import 'package:heli_bifrost_project/constants.dart';

class ChatInputField extends StatelessWidget {
  Function(String text)? onSendButtonPressed;
  ChatInputField({Key? key, Function(String text)? onSendButtonPressed})
      : super(key: key) {
    this.onSendButtonPressed = onSendButtonPressed;
  }

  TextEditingController messageTextFieldController = TextEditingController();

  void _onSendButtonPressed() {
    print('Send message btn');
    if (onSendButtonPressed != null) {
      onSendButtonPressed!(messageTextFieldController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: lightPurple,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: lightLilac.withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    //?:====== Emoji Button ======:?
                    IconButton(
                      onPressed: () {
                        print('Emoji btn');
                      },
                      icon: Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: messageTextFieldController,
                        decoration: const InputDecoration(
                          hintText: "พิมพ์ข้อความที่นี่...",
                          hintStyle: TextStyle(fontSize: 12),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    //?=== Send Message Button ===?
                    IconButton(
                      onPressed: _onSendButtonPressed,
                      icon: Icon(
                        Icons.send,
                        color: darkGreen,
                      ),
                    ),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1!
                    //       .color!
                    //       .withOpacity(0.64),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
