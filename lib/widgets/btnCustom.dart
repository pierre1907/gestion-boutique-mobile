import 'package:flutter/material.dart';

class btnCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const btnCustom({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: TextStyle(fontSize: 18),
      ),
      child: Text(text),
    );
  }
}
