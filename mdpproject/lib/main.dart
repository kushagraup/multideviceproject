import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdpproject/Resources/auth.dart';
import 'package:splashscreen/splashscreen.dart';
import 'pages/login_screen.dart';
import 'pages/homepage.dart';
import 'Resources/Widgets/custom_button.dart';
import 'Resources/Widgets/custom_inputfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loadingpage(),
      theme: ThemeData.light(),
    );
  }
}

class Loadingpage extends StatelessWidget {
  const Loadingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Color(0xff222831),
      seconds: 5,
      navigateAfterSeconds: loginhome(),
      title: Text("To-Do List",
          style: GoogleFonts.oswald(
            fontSize: 40,
            color: Colors.white,
          )),
      image: Image.asset(
        'images/1.png',
      ),
      photoSize: 100,
      loaderColor: Color(0xff00ADB5),
    );
  }
}

class loginhome extends StatefulWidget {
  @override
  _loginhomeState createState() => _loginhomeState();
}

class _loginhomeState extends State<loginhome> {
  final FocusNode myfocus = FocusNode();
  final AuthenticationServices _auth = AuthenticationServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff222831),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "MDP CRUD APP",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.oswald(fontSize: 50, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: Image(
                  image: AssetImage(
                    'images/2.png',
                  ),
                  height: size.height * 0.3,
                  width: size.width * 0.7,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EntryField(
                      textEditingController: _emailController,
                      label: "Email Address",
                      hide: false,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EntryField(
                      textEditingController: _passwordController,
                      label: "Password",
                      hide: true,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedButton(
                      text: "Sign In",
                      onPressed: () async {
                        dynamic result = await _auth.loginUser(
                            _emailController.text, _passwordController.text);
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Unsucessful!")));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => crudmdp(
                                        uid: _auth.getUid(),
                                        auth: _auth.user(),
                                      )));
                        }
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not Registered?",
                    style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Email();
                      }));
                    },
                    child: Text(
                      "Create Account",
                      style: GoogleFonts.oswald(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff488FB1)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
