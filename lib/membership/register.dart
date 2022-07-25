import 'package:date_field/date_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class Regiser extends StatefulWidget {
  const Regiser({Key? key}) : super(key: key);

  @override
  State<Regiser> createState() => _RegiserState();
}

class _RegiserState extends State<Regiser> {
  TextEditingController tcNickname = TextEditingController();
  TextEditingController tcEmail = TextEditingController();
  TextEditingController tcPassword = TextEditingController();
  TextEditingController tcConfirmedPassword = TextEditingController();
  bool showPassword = true;
  DateTime? dateOfBirth;
  String gender = '';

  void _showDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
            ],
          ),
        );
      },
    );
  }

  void _register() async {
    List inputs = [
      tcEmail.text,
      tcPassword.text,
      tcNickname.text,
      gender,
      dateOfBirth.toString().split(' ')[0]
    ];

    print(inputs);

    for (var input in inputs) {
      if (input == null || input == '') {
        return _showDialog(
          title: 'Warning',
          message: 'Please check your input.',
        );
      }
    }

    if (tcPassword.text != tcConfirmedPassword.text) {
      return _showDialog(
        title: "Warning",
        message: 'Password does not match, please check your input.',
      );
    }

    print(dateOfBirth.toString().split(' ')[0]);
    String registerUrl =
        kIsWeb ? dotenv.env['SERVER_WEB_ADDRESS']! : dotenv.env['SERVER_ADDRESS']!;
    registerUrl += '/register';
    Response response = await GetConnect().post(registerUrl, {
      "email": tcEmail.text,
      "password": tcPassword.text,
      "nickname": tcNickname.text,
      "sex": gender == 'male' ? 0 : 1,
      "date_of_birth": dateOfBirth.toString().split(' ')[0]
    });

    if (!response.status.isOk) {
      return _showDialog(
        title: 'Error',
        message: response.body.toString(),
      );
    }

    Get.toNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/login_bg.JPG",
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.93,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'หน้าสร้างบัญชี',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // ),
                  ],
                ),
                //username
                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 32, 64, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อเล่น',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: tcNickname,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            )),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'อีเมล',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: tcEmail,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            )),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'วันเดือนปีเกิด',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: DateTimeFormField(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.event_note,
                              color: Colors.black,
                            ),
                            labelText: 'เลือกวันที่',
                            labelStyle: TextStyle(fontSize: 12),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (DateTime? e) {
                            return (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null;
                          },
                          onDateSelected: (DateTime value) {
                            print(value);
                            dateOfBirth = value;
                          },
                        ),
                      ),
                      Text(
                        'เพศ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  print(gender);
                                });
                              }),
                          Text(
                            'ชาย',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  print(gender);
                                });
                              }),
                          Text(
                            'หญิง',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //password
                      Text(
                        'รหัสผ่าน',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: tcPassword,
                        style: TextStyle(color: Colors.black),
                        obscureText: showPassword,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'ยืนยันรหัสผ่าน',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: tcConfirmedPassword,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            )),
                      ),

                      //button sign up
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Center(
                          child: SizedBox(
                            width: 0.5 * size.width,
                            height: 0.05 * size.height,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, '/chat');
                                _register();
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                primary: Colors.white,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                "สมัครสมาชิก",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "\“ถ้าพี่มีบัญชีอยู่แล้วก็ ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "กดที่นี่",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  " เลยก็ได้นะ\”",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
