import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget{
  final String buttonText;
  final VoidCallback action;

  const FullWidthButton({Key? key,
    required this.buttonText,
    required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[900],
      ),
      child: const Text(
        "Log in",
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}



