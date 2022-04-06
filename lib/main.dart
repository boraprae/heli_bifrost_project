import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heli_bifrost_project/chats/chatScreen.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/chat',
      routes: {
        '/chat': (context) => ChatScreen(),
      },
    ),
  );
}
