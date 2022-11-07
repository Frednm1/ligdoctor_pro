import 'package:flutter/cupertino.dart';
import 'package:ligdoctor_pro/pages/home/financial/financial.dart';
import 'package:ligdoctor_pro/pages/home/health_orientation/health_orientation.dart';
import 'package:ligdoctor_pro/pages/home/support/support.dart';
import 'package:ligdoctor_pro/pages/home/teleconsults/teleconsults.dart';
import 'package:ligdoctor_pro/pages/login/password_recover.dart';
import 'package:ligdoctor_pro/pages/login/start_page.dart';
import 'package:ligdoctor_pro/pages/register/register_page.dart';
import 'package:ligdoctor_pro/utils/loading.dart';
import '../pages/home/home.dart';
import '../pages/login/login_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/start': (context) => const StartPage(),
    '/password-recover': (context) => const PasswordRecover(),
    '/health-orientation': (context) => const HealthOrientation(),
    '/loading': (context) => const Loading(),
    '/teleconsults': (context) => const Teleconsults(),
    '/support': (context) => const Support(),
    '/register': (context) => const RegisterPage(),
    '/login': (context) => const LoginPage(),
    '/home': (context) => const Home(),
    '/financial': (context) => const Financial(),
  };
  static String login = '/login';
  static String register = '/register';
  static String teleconsults = '/teleconsults';
  static String healthOrientation = '/health-orientation';
  static String passwordRecover = '/password-recover';
  static String start = '/start';
  static String financial = '/financial';
  static String loading = '/loading';
  static String support = '/support';
  static String home = '/home';
}
