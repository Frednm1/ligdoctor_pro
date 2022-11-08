// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool belongsToCurrentUser;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.start
          : MainAxisAlignment.end ,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .6,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: belongsToCurrentUser
                ? Colors.grey[300] 
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: belongsToCurrentUser
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white ,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
