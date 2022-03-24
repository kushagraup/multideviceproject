import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdpproject/Resources/auth.dart';
import 'package:mdpproject/Resources/Widgets/custom_button.dart';
import 'package:mdpproject/Resources/Widgets/custom_inputfield.dart';

import '../main.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final AuthenticationServices _auth = AuthenticationServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FocusNode myFocus = FocusNode();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff222831),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.oswald(fontSize: 40, color: Colors.white),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image(
                    image: AssetImage('images/3.png'),
                    height: size.height * 0.3,
                    width: size.width * 0.7,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: EntryField(
                      label: "Email Address",
                      hide: false,
                      textEditingController: _emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: EntryField(
                      label: "Password",
                      hide: true,
                      textEditingController: _passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RoundedButton(
                        text: "Register",
                        onPressed: () async {
                          dynamic result = await _auth.createNewUser(
                              _emailController.text, _passwordController.text);
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Registration Unsucessful!")));
                          } else {
                            myFocus.unfocus();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => loginhome()));
                          }
                        }),
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
