import 'package:flutter/material.dart';
import '../pages/splash_screen.dart';
import '../services/auth_service.dart';
import '../utils/routes.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

_startNavigator(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.start);
}

_homeNavigator(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.home);
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _check().then((value) {
      if (value == true) {
        _homeNavigator(context);
      } else {
        _startNavigator(context);
      }
    });
  }

  Future<bool> _check() async {
    return Autentication().callCheck();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
