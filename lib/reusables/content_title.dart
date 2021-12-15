import 'package:flutter/material.dart';


class ContentTitle extends StatelessWidget {
  final String title;
  const ContentTitle({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black87,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
