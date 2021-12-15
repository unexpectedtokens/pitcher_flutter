import 'package:flutter/material.dart';



class LikesDisplay extends StatelessWidget {
  final bool likedByUser;
  final void Function() action;
  final int likes;
  const LikesDisplay({
    Key? key,
    required this.likedByUser,
    required this.action,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
          child: IconButton(
            icon: Icon(
                likedByUser ? Icons.favorite : Icons.favorite_border
            ),
            onPressed: action,
            color: Colors.redAccent,
          ),
        ),

        Text(
            "$likes",
            style: const TextStyle(
              fontSize: 20.0,
            )
        ),

      ],
    );
  }
}
