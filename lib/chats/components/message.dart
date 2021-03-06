import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heli_bifrost_project/chats/components/text_message.dart';
import 'package:heli_bifrost_project/constants.dart';
import 'package:heli_bifrost_project/models/chatMessage.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            const CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage("assets/images/heli_profile.jpg"),
            ),
            const SizedBox(
              width: kDefaultPadding / 2,
            ),
          ],
          Flexible(
            child: TextMessage(
              message: message,
            ),
          ),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.80,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color:  message.isSender ? lightLilac : lightBlueSky,
        borderRadius: BorderRadius.circular(30),
      ),
      child: AutoSizeText(
        
        message.text,
        style: TextStyle(
          color: message.isSender
              ? Colors.black
              : Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }
}

// class MessageStatusDot extends StatelessWidget {
//   final MessageStatus? status;

//   const MessageStatusDot({Key? key, this.status}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Color dotColor(MessageStatus status) {
//       switch (status) {
//         case MessageStatus.not_sent:
//           return Colors.red;
//         case MessageStatus.not_view:
//           return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
//         case MessageStatus.viewed:
//           return Colors.purple;
//         default:
//           return Colors.transparent;
//       }
//     }

//     return Container(
//       margin: EdgeInsets.only(left: kDefaultPadding / 2),
//       height: 12,
//       width: 12,
//       decoration: BoxDecoration(
//         color: dotColor(status!),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         status == MessageStatus.not_sent ? Icons.close : Icons.done,
//         size: 8,
//         color: Theme.of(context).scaffoldBackgroundColor,
//       ),
//     );
//   }
// }
