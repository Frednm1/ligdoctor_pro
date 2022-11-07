// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserPageButton extends StatelessWidget {
  final String userButtonText;
  final Widget userButtonIcon;
  final VoidCallback func;
  const UserPageButton({
    Key? key,
    required this.userButtonText,
    required this.userButtonIcon,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: func,
            child: Container(
              height: MediaQuery.of(context).size.height * .07,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(13),
              ),
              width: MediaQuery.of(context).size.width * .8,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: userButtonIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 1),
                    child: Text(
                      userButtonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
