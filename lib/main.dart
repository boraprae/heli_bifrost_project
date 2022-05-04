
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heli_bifrost_project/chats/chatScreen.dart';
import 'package:heli_bifrost_project/login/login.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Mali',
        primaryColor: Colors.black,
        // bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/chat': (context) => ChatScreen(),
      },
    ),
  );
}
