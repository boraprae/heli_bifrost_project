import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heli_bifrost_project/chats/chatScreen.dart';
import 'package:heli_bifrost_project/membership/login.dart';
import 'package:heli_bifrost_project/membership/register.dart';

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
      initialRoute: '/register',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Regiser(),
        '/chat': (context) => ChatScreen(),
      },
    ),
  );
}
