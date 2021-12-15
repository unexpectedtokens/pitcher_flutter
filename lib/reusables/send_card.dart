import 'package:pitcher/models/send.dart';
import 'package:flutter/material.dart';



class SendCard extends StatelessWidget {
  final Send send;
  const SendCard({
    Key? key,
    required this.send
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading:  CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blueAccent,
        child: Text(send.sender.username[0].toUpperCase()),
      ),
      title: Text(
          send.sender.username
      ),
      subtitle: const Text(
          "on 24th of march"
      ),
      trailing:  Text("${send.tries} tries"),
      contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0
      ),
    );
  }
}
