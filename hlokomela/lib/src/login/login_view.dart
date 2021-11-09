import 'package:flutter/material.dart';
import 'package:hlokomela/src/service/call_api.dart';
import 'package:hlokomela/src/widget/custome_center.dart';
import 'package:hlokomela/src/widget/progress_button.dart';
import 'package:hlokomela/src/widget/custom_text_field.dart';

class LoginRegisterView extends StatefulWidget {
  const LoginRegisterView({Key? key, required this.type}) : super(key: key);
  static const String routeNameLogin = "/login";
  static const String routeNameRegister = "/register";
  final String type;
  @override
  State<LoginRegisterView> createState() => _LoginRegisterViewViewState();
}

class _LoginRegisterViewViewState extends State<LoginRegisterView> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  ButtonState buttonState = ButtonState.normal;

  sendLoginRequest() {
    setState(() {
      buttonState = ButtonState.inProgress;
    });
    CallApi.post(context, "route").then((value) => {
      setState(() {
        buttonState = ButtonState.normal;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(widget.type,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                children: [
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          CustomCenter(
                            padding: const EdgeInsets.only(top: 12,),
                            child: CustomTextField(
                              labelText: "Username",
                              hintText: "Enter your username",
                              controller: usernameController,
                            ),
                          ),
                          CustomCenter(
                            padding: const EdgeInsets.only(top: 12,),
                            child: CustomTextField(
                              labelText: "Password",
                              hintText: "Enter your password",
                              controller: passwordController,
                            ),
                          ),
                          CustomCenter(
                            padding: const EdgeInsets.only(top: 12,),
                            child: ProgressButton(
                                buttonState: buttonState,
                                child: Text(
                                  widget.type,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    )
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
