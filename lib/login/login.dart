import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
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
                Container(
                  width: size.width,
                  height: size.height * 0.6,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'หน้าเข้าสู่ระบบ',
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
                        'อีเมล',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: usernameController,
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
                        controller: passwordController,
                        style: TextStyle(color: Colors.black),
                        obscureText: showPassword,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                            )),
                      ),
                      //forget password?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              child: Text(
                                "ลืมรหัสผ่าน?",
                                style: TextStyle(fontSize: 12),
                              ),
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              onPressed: () {}),
                        ],
                      ),
                      //button sign in
                      Center(
                        child: SizedBox(
                          width: 0.5 * size.width,
                          height: 0.05 * size.height,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (usernameController.text == '' ||
                                  passwordController.text == '') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Warning!'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              'Please type your email and password first.'),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                //  var Loging = await login();
                                //saveToken(Loging.body);
                                // if (Loging.statusCode < 299) {
                                //   Navigator.pushNamed(context, '/mainMenu');
                                //   usernameController.clear();
                                //   passwordController.clear();
                                // } else {
                                // loginFailed(Loging.body);
                                //}
                              }
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
                              "เข้าสู่ระบบ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                                  "\“พี่จะสร้างบัญชีใหม่ก็ได้นะ \”",
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
                                  " เลย\”",
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
                              Navigator.pushNamed(context, '/signUppage');
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
