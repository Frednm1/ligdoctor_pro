import 'package:flutter/cupertino.dart';
import 'package:ligdoctor_pro/login/password_recover.dart';
import 'package:ligdoctor_pro/login/start_page.dart';
import 'package:ligdoctor_pro/register/register_page.dart';
import '../home/home.dart';
import '../login/login_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/start': (context) => const StartPage(),
    '/password-recover': (context) => const PasswordRecover(),
    '/register': (context) => const RegisterPage(),
    '/login': (context) => const LoginPage(),
    '/home': (context) => const Home(),
  };
  static String login = '/login';
  static String register = '/register';
  static String passwordRecover = '/password-recover';
  static String start = '/start';
  static String home = '/home';
}
