import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
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

  final _chatListViewController = ScrollController();

  void _sendMessage(String textMessage) async {
    print('Sending query.. $textMessage');
    String serverAddress =
        kIsWeb ? 'http://localhost:3001' : dotenv.env['SERVER_ADDRESS']!;
    Response response = await GetConnect(timeout: const Duration(seconds: 15))
        .post(serverAddress + '/query', {"query": textMessage});

    if (response.isOk) {
      // print(response.body);
      setState(() {
        demeChatMessages.add(ChatMessage(
            text: response.body['queryResult']['fulfillmentText'],
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: false));
        _scrollDown();
      });
    } else {
      Get.defaultDialog(
          title: 'Error',
          middleText: response.statusCode == null
              ? "Request timed out"
              : "Cannot send message, please try again");
    }
  }

  void _scrollDown() {
    if (_chatListViewController.position.maxScrollExtent != 0) {
      _chatListViewController.animateTo(
        _chatListViewController.position.maxScrollExtent + 70,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }

    // _chatListViewController.jumpTo(_chatListViewController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double chatListViewTopOffset = 110;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[lightLilac, lightBlueSky],
              stops: [0.1, 2.5],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                child: Row(
                  children: [
                    const BackButton(),
                    CircleAvatar(
                      minRadius: 30,
                      maxRadius: 35,
                      backgroundImage:
                          AssetImage("assets/images/heli_profile.jpg"),
                    ),
                    SizedBox(width: kDefaultPadding * 0.75),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "สถานะวันนี้ของเฮลิ",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\"วันที่ดีที่สุดคือวันที่ถูกหวยยังไงล่ะ!\"",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: size.width * 0.35),
                    PopupMenuButton(
                      onSelected: (value) {
                        setState(() {
                          selectedItem = value.toString();
                        });
                        //print(value);
                        Navigator.pushNamed(context, value.toString());
                      },
                      itemBuilder: (BuildContext bc) {
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
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: chatListViewTopOffset,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      //Chat area
                      Container(
                        width: size.width,
                        height: size.height -
                            (chatListViewTopOffset *
                                1.85), // fix text input overlapping chat listview
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding + 8),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _chatListViewController,
                            itemCount: demeChatMessages.length,
                            itemBuilder: (context, index) =>
                                Message(message: demeChatMessages[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ChatInputField(
                  onSendButtonPressed: (text) {
                    if (text.trim().isNotEmpty) {
                      setState(() {
                        demeChatMessages.add(ChatMessage(
                            text: text,
                            messageType: ChatMessageType.text,
                            messageStatus: MessageStatus.viewed,
                            isSender: true));
                        _scrollDown();
                      });

                      _sendMessage(text);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
