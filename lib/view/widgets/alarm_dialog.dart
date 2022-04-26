import 'package:flutter/material.dart';

class AlarmDialogCustom extends StatelessWidget {
  final String text;
  final Function() confirmCallback;
  final Function() cancellCallback;

  AlarmDialogCustom(
      {required this.text,
      required this.confirmCallback,
      required this.cancellCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: [
        TextButton(
          onPressed: cancellCallback,
          child: Text(
            'No',
          ),
        ),
        TextButton(
          onPressed: confirmCallback,
          child: Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
