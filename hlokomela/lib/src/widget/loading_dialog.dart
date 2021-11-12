import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Center(
            child : Text(title ?? 'Loading')
        ),
        content: Wrap(
          children : const [
            Center(
                child : CircularProgressIndicator()
            ),
          ],
        )
    );
  }
}
