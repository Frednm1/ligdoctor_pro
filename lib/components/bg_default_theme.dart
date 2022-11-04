import 'package:flutter/material.dart';

class BgDefaultTheme extends StatelessWidget {
  const BgDefaultTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(17, 0, 0, 0),
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/default-bg.png',
            fit: BoxFit.cover,
            color: const Color.fromARGB(255, 255, 111, 0),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
        ),
      ],
    );
  }
}
