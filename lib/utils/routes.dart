import 'package:flutter/cupertino.dart';
import 'package:ligdoctor_pro/pages/home/financial/financial.dart';
import 'package:ligdoctor_pro/pages/home/health_orientation/health_orientation.dart';
import 'package:ligdoctor_pro/pages/home/my_account/change_password.dart';
import 'package:ligdoctor_pro/pages/home/my_account/edit_location.dart';
import 'package:ligdoctor_pro/pages/home/my_account/user_data.dart';
import 'package:ligdoctor_pro/pages/home/my_account/user_page.dart';
import 'package:ligdoctor_pro/pages/home/patients/patients.dart';
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
    //user
    '/user-data': (context) => const UserData(),
    '/change-password': (context) => const ChangePassword(),
    '/edit-location': (context) => const EditLocation(),

    //login - register
    '/start': (context) => const StartPage(),
    '/password-recover': (context) => const PasswordRecover(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),

    //home
    '/user-page': (context) => const UserPage(),
    '/health-orientation': (context) => const HealthOrientation(),
    '/teleconsults': (context) => const Teleconsults(),
    '/support': (context) => const Support(),
    '/home': (context) => const Home(),
    '/financial': (context) => const Financial(),
    '/patients': (context) => const Patients(),

    //utils
    '/loading': (context) => const Loading(),
  };
  static String login = '/login';
  static String register = '/register';
  static String userData = '/user-data';
  static String editLocation = '/edit-location';
  static String changePassword = '/change-password';
  static String userPage = '/user-page';
  static String teleconsults = '/teleconsults';
  static String healthOrientation = '/health-orientation';
  static String passwordRecover = '/password-recover';
  static String start = '/start';
  static String patients = '/patients';
  static String financial = '/financial';
  static String loading = '/loading';
  static String support = '/support';
  static String home = '/home';
}
