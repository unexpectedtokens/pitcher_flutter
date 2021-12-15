import 'package:flutter/material.dart';

class Input extends StatelessWidget {

  final Function(String)? handleChange;
  final String labelText;
  final TextEditingController controller;
  const Input({
    Key? key,
    this.handleChange,
    required this.labelText,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: handleChange,

      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Username"),
      ),
      controller: controller,
    );
  }
}
