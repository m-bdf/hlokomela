import 'package:flutter/material.dart';
import 'package:hlokomela/src/login/login_view.dart';
import 'package:hlokomela/src/service/call_api.dart';
import 'package:hlokomela/src/widget/custom_button.dart';
import 'package:shake/shake.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);
  static const String routeName = "/";

  @override
  State<WelcomeView> createState() => _WelcomeView();
}

class _WelcomeView extends State<WelcomeView> {
  @override
  void initState() {
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        TextEditingController controller =
            TextEditingController(text: CallApi.route);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Change ip server'),
            content: const Text('Enter or modify IP'),
            actions: <Widget>[
              TextField(
                controller: controller,
              ),
              TextButton(
                onPressed: () => {Navigator.of(context).pop(controller.text)},
                child: const Text('Validate'),
              ),
            ],
          ),
        ).then((value) => {CallApi.route = controller.text});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Welcome to\nHlokomela",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Image.asset('assets/icons/notebook.png',
                width: size.width * 0.6, height: size.height * 0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                child: const Text("Login"),
                onPress: () {
                  Navigator.of(context)
                      .pushNamed(LoginRegisterView.routeNameLogin);
                },
                width: size.width * 0.3,
              ),
              SizedBox(width: size.width * 0.1),
              CustomButton(
                child: const Text("Register"),
                onPress: () {
                  Navigator.of(context)
                      .pushNamed(LoginRegisterView.routeNameRegister);
                },
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
