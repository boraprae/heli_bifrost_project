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
      body: Column(
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
                  'ชื่อผู้ใช้งาน',
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
                        borderSide: BorderSide(color: Colors.black),
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
                        borderSide: BorderSide(color: Colors.black),
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
              ],
            ),
          ),

          //forget password?
          TextButton(
              child: Text(
                "ลืมรหัสผ่าน?",
                style: TextStyle(fontSize: 12),
              ),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {}),
          //button sign in
          SizedBox(
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
                            Text('Please type your email and password first.'),
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
                primary: Colors.black,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "เข้าสู่ระบบ",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                child: Text("\“พี่จะสร้างบัญชีใหม่ก็ได้นะ กดที่นี่ เลย\”"),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signUppage');
                }),
          ),
        ],
      ),
    );
  }
}
