import 'package:flutter/material.dart';

class ErrorDailog extends StatelessWidget {
  final String message;
  const ErrorDailog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Center(
            child: Text("Ok"),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.red),
        )
      ],
    );
  }
}
