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
    Response response = await GetConnect(timeout: const Duration(seconds: 30))
        .post(serverAddress + '/query', {"query": textMessage});

    if (response.isOk) {
      // print(response.body);
      if (response.body['service_type'] == 'dialogflow') {
        var data = response.body['data'];
        var messages = data['queryResult']['fulfillmentMessages'];
        setState(() {
          for (var message in messages) {
            demeChatMessages.add(ChatMessage(
                text: message['text']['text'][0],
                messageType: ChatMessageType.text,
                messageStatus: MessageStatus.viewed,
                isSender: false));
            _scrollDown();
          }
        });
      } else if (response.body['service_type'] == 'openai') {
        /*
        openAI completion response:
          {
            "id": "cmpl-5386T799VJPBmxUbcbf5EahSvcOll",
            "object": "text_completion",
            "created": 1651427817,
            "model": "text-davinci:002",
            "choices": [
                {
                    "text": "\nHeli: Hey there! How are you doing today?",
                    "index": 0,
                    "logprobs": null,
                    "finish_reason": "stop"
                }
            ]
          }
        */
        var data = response.body['data'];
        String message = data['choices'][0]['text_th'];
        setState(() {
          demeChatMessages.add(ChatMessage(
              text: message.split('Heli:').length > 1
                  ? message.split('Heli:')[1].trim()
                  : message.trim(),
              messageType: ChatMessageType.text,
              messageStatus: MessageStatus.viewed,
              isSender: false));
          _scrollDown();
        });
      }
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
        _chatListViewController.position.maxScrollExtent + 100,
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
