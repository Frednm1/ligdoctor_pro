import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(this.buttonColor, this.buttonText, {Key? key})
      : super(key: key);
  final Color buttonColor;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
        width: MediaQuery.of(context).size.width * 0.75,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
