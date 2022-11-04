import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/curved_border.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import '../../utils/routes.dart';
import '../splash_screen.dart';

class PasswordRecover extends StatefulWidget {
  const PasswordRecover({Key? key}) : super(key: key);

  @override
  State<PasswordRecover> createState() => _PasswordRecoverState();
}

class _PasswordRecoverState extends State<PasswordRecover> {
  final _cpfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cpfFocus = FocusNode();

  _recoverRequest(String cpf) async {
    var url = Uri.https(
        'sandbox-api.excellencemedical.com.br', '/api/v1/resetPassword');
    var response = await http.post(url, body: {
      "cpf": cpf,
    });
    var data = jsonDecode(response.body);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Você receberá um email'),
          content: Text(
              'Você receberá um e-mail em ${data['email']} para recuperar sua senha.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _start(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        );
      },
    );
  }

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
                            'Digite seu cpf para recuperar sua senha.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            focusNode: _cpfFocus,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                            controller: _cpfController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null) {
                                return 'Digite seu cpf';
                              } else if (value.length != 14) {
                                return 'cpf inválido';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 244, 241, 241),
                              labelText: 'CPF',
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _recoverRequest(_cpfController.text);
                                    _cpfFocus.unfocus();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const SplashScreen();
                                    }));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize:
                                      Size(displaySize.width * 0.8, 50),
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
