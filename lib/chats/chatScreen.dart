import 'package:flutter/material.dart';
import 'package:heli_bifrost_project/chats/components/chat_input_field.dart';
import 'package:heli_bifrost_project/chats/components/message.dart';
import 'package:heli_bifrost_project/constants.dart';
import 'package:heli_bifrost_project/models/chatMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var selectedItem = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/heli_profile.jpg"),
            ),
            SizedBox(width: kDefaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "สถานะวันนี้ของเฮลิ",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Text(
                  "โชคดีที่มีเฮลิ",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
        actions: [
          //!--- Assume the menu ---!
          PopupMenuButton(onSelected: (value) {
            setState(() {
              selectedItem = value.toString();
            });
            //print(value);
            Navigator.pushNamed(context, value.toString());
          }, itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                child: Text("Hello"),
                value: '/hello',
              ),
              PopupMenuItem(
                child: Text("About"),
                value: '/about',
              ),
              PopupMenuItem(
                child: Text("Contact"),
                value: '/contact',
              )
            ];
          }),
          SizedBox(width: kDefaultPadding / 2),
        ],
      ),
      body: Column(
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
      ),
    );
  }
}
