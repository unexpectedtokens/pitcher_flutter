import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget{
  final String buttonText;
  final VoidCallback action;
  final Icon? icon;
  final bool active;


  const FullWidthButton({
    Key? key,
    required this.active,
    required this.buttonText,
    required this.action,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    var children = <Widget>[
      Text(
        buttonText,
        style: const TextStyle(
            color: Colors.white
        ),
      ),
    ];
    if(icon != null){
      children.add(Container(
        child: icon!,
        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      )
      );
    }
    return TextButton(

      onPressed: active ? action : null,
      style: TextButton.styleFrom(

        backgroundColor: active ? Colors.grey[900] : Colors.grey[400],
      ),

      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children
      ),
    );
  }
}



