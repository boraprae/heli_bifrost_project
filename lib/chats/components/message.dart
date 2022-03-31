import 'package:flutter/material.dart';
import 'package:heli_bifrost_project/chats/components/text_message.dart';
import 'package:heli_bifrost_project/constants.dart';
import 'package:heli_bifrost_project/models/chatMessage.dart';

// import 'audio_message.dart';
// import 'text_message.dart';
// import 'video_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    // Widget messageContaint(ChatMessage message) {
    //   switch (message.messageType) {
    //     case ChatMessageType.text:
    //       return TextMessage(message: message);
    //     // case ChatMessageType.audio:
    //     //   return AudioMessage(message: message);
    //     // case ChatMessageType.video:
    //       // return VideoMessage();
    //     default:
    //       return SizedBox();
    //   }
    // }
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: SizedBox(
        child: Row(
          //  mainAxisAlignment: message.isSender
          //     ? MainAxisAlignment.end
          //     : MainAxisAlignment.start,
          // children: [
          //   if (!message.isSender) ...[
          //     CircleAvatar(
          //       radius: 12,
          //       backgroundImage: AssetImage("assets/images/heli_profile.jpg"),
          //     ),
          //     SizedBox(width: kDefaultPadding / 2),
          //   ],
          //   TextMessage(message: message),
          //   if (message.isSender)
          //     MessageStatusDot(status: message.messageStatus)
          // ],
          mainAxisAlignment: message.isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!message.isSender) ...[
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage("assets/images/heli_profile.jpg"),
              ),
              SizedBox(width: kDefaultPadding / 2),
            ],
            TextMessage(message: message),
            if (message.isSender)
              MessageStatusDot(status: message.messageStatus)
          ],
        ),
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return Colors.red;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return Colors.purple;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
