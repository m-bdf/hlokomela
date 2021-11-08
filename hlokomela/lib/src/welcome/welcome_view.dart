import 'package:flutter/material.dart';
import 'package:hlokomela/src/widget/custom_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Welcome to\nHlokomela", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Center(
            child : Image.asset('assets/icons/notebook.png', width: size.width * 0.6, height: size.height * 0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                child: const Text("Login"),
                onPress: () {},
                width: size.width * 0.3,
              ),
              SizedBox(width: size.width * 0.1),
              CustomButton(
                child: const Text("Register"),
                onPress: () {},
                width: size.width * 0.3,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
