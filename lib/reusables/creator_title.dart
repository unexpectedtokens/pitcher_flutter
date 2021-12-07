import 'package:flutter/material.dart';



class ContentTitle extends StatelessWidget {
  final String username;
  const ContentTitle({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
        "Created by Daniel de Jong",
        style: TextStyle(
          color: Colors.blue,
        )
    ),
  }
}
