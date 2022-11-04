import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ligdoctor_pro/login/password_recover.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/curved_border.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import '../../utils/routes.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final _formKey = GlobalKey<FormState>();

  Future<bool> _loginRequest(String email, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        Uri.https('sandbox-api.excellencemedical.com.br', '/api/v1/login');

    try {
      var response = await http.post(url, body: {
        "email": email,
        "password": pass,
      });
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        await prefs.remove("token");
        await prefs.setString("token", data['token']);
        Autentication().callCheck();
        return true;
      }
    } finally {}
    return false;
  }

  // _goToHome(BuildContext context) {
  //   Navigator.of(context).pushReplacementNamed(Routes.home);
  // }

  @override
  Widget build(BuildContext context) {
    final Size displaySize = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            SizedBox(
              width: displaySize.width,
              height: displaySize.height * .5,
              child: Image.asset(
                'assets/images/doctor.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Platform.isIOS ? 35 : 20),
              child: IconButton(
                onPressed: () => _start(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.white70,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: displaySize.height * .3),
              width: displaySize.width,
              height: displaySize.height * .7,
              child: Stack(
                children: [
                  const CurvedBorder(Colors.white),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset(
                          'assets/images/default-bg.png',
                          fit: BoxFit.cover,
                          width: displaySize.width,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: displaySize.width,
                    margin: EdgeInsets.only(top: displaySize.height * .1),
                    padding: EdgeInsets.symmetric(
                      horizontal: displaySize.width * .1,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/images/Logo-escura.png',
                            scale: 0.7,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Digite seus dados para entrar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            focusNode: focusNode1,
                            onFieldSubmitted: (_) {
                              Focus.of(context).requestFocus(focusNode2);
                            },
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Digite seu email';
                              } else if (!EmailValidator.validate(value)) {
                                return 'email inválido';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 244, 241, 241),
                              labelText: 'Email',
                              contentPadding: const EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            focusNode: focusNode2,
                            controller: _passwordController,
                            validator: (str) {
                              if (str == null) {
                                return "Digite sua senha";
                              } else if (str.length < 4) {
                                return "Senha muito curta";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 244, 241, 241),
                              labelText: 'Senha',
                              contentPadding: const EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const PasswordRecover();
                              }));
                            },
                            child: Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _loginRequest(_emailController.text,
                                            _passwordController.text)
                                        .then((value) {
                                      if (value) {
                                        // _goToHome(context);
                                        print('logado');
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                              "Cpf e/ou senha incorretos",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK'),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize:
                                      Size(displaySize.width * 0.6, 35),
                                ),
                                child: const Text(
                                  'ENTRAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_start(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.start);
}
