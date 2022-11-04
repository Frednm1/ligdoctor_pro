import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Logo-escura.png'),
          const SizedBox(
            height: 30,
            width: 30,
            child: FittedBox(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
