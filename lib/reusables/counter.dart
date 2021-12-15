import 'package:flutter/material.dart';




class Counter extends StatelessWidget {
  final VoidCallback add;
  final VoidCallback remove;
  final int count;


  const Counter({
    Key? key,
    required this.add,
    required this.remove,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          IconButton(
              onPressed: remove,
              color: Colors.blueAccent,
              iconSize: 50,
              icon: const Icon(
                  Icons.remove
              )
          ),
          Text(
            "$count",
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 30,
            ),
          ),
          IconButton(
            onPressed: add,
            iconSize: 50,
            icon: const Icon(
                Icons.add
            ),
            color: Colors.blueAccent,
          )
        ]
    );
  }
}
