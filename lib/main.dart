import 'package:flutter/material.dart';
import 'package:heli_bifrost_project/chats/chatScreen.dart';

void main() {
  runApp(
      MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/chat',
      routes: {
        '/chat': (context) => ChatScreen(),
      },
    ),
  );
}
