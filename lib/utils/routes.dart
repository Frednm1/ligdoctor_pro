import 'package:flutter/cupertino.dart';
import 'package:ligdoctor_pro/login/password_recover.dart';
import 'package:ligdoctor_pro/login/start_page.dart';
import '../login/login_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/start': (context) => const StartPage(),
    '/password-recover': (context) => const PasswordRecover(),
    '/login': (context) => const LoginPage(),
  };
  static String login = '/login';
  static String passwordRecover = '/password-recover';
  static String start = '/start';
}
