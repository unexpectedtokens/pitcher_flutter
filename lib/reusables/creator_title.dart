import 'package:flutter/material.dart';



class CreatorText extends StatelessWidget {
  final String username;
  const CreatorText({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        "Created by $username",
        style: const TextStyle(
          color: Colors.blue,
        )
    );
  }
}
