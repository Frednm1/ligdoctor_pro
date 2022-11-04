import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../../utils/routes.dart';
import 'dart:io' show Platform;
import "package:email_validator/email_validator.dart";

import '../../components/bg_default_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool checked = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();

  final _formKey = GlobalKey<FormState>();

  void submit(String name, String email, String cpf, String password) async {
    var url = Uri.https(
        'sandbox-api.excellencemedical.com.br', '/api/v1/userRegister');
    var response = await http.post(url, body: {
      "name": name,
      "cpf": cpf,
      "email": email,
      "password": password,
      "type": "customer",
      "c_password": password
    });
    var data = jsonDecode(response.body);
    print(response.body);
    if (data['error'] == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            data['msg'],
            style: const TextStyle(
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
      return null;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "registrado com sucesso",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _returnLogin(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  _returnLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final Size displaySize = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var checkbox = Checkbox(
      value: checked,
      onChanged: (bool? value) {
        setState(() {
          checked = value!;
        });
      },
      focusColor: Theme.of(context).colorScheme.secondary,
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context)
                .colorScheme
                .secondary; // the color when checkbox is selected;
          }
          return Theme.of(context)
              .colorScheme
              .secondary; //the color when checkbox is unselected;
        },
      ),
      checkColor: Colors.white,
      activeColor: Theme.of(context).colorScheme.secondary,
      shape: const CircleBorder(
        side: BorderSide(
          style: BorderStyle.solid,
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            const BgDefaultTheme(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      'assets/images/default-bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  top: displaySize.height * .2,
                  left: displaySize.width * .1,
                  right: displaySize.width * .1),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Logo-escura.png',
                      scale: .7,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Informe Seus dados Corretamente',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (str) {
                              if (str == null) {
                                return "Por favor digite seu nome";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            focusNode: focusNode1,
                            controller: _nameController,
                            onFieldSubmitted: (_) {
                              Focus.of(context).requestFocus(focusNode2);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(10, 0, 0, 0),
                              labelText: "Nome",
                              hintStyle: const TextStyle(
                                color: Colors.black87,
                              ),
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
                            height: 15,
                          ),
                          TextFormField(
                            validator: (str) {
                              if (str == null) {
                                return "Por favor digite seu email";
                              } else if (!EmailValidator.validate(str)) {
                                return 'Email Inválido';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            controller: _emailController,
                            focusNode: focusNode2,
                            onFieldSubmitted: (_) {
                              Focus.of(context).requestFocus(focusNode3);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(10, 0, 0, 0),
                              labelText: "E-mail",
                              hintStyle: const TextStyle(
                                color: Colors.black87,
                              ),
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
                            height: 15,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                            focusNode: focusNode3,
                            onFieldSubmitted: (_) {
                              Focus.of(context).requestFocus(focusNode4);
                            },
                            validator: (str) {
                              if (str == null) {
                                return "Por favor digite seu cpf";
                              } else if (str.length != 14) {
                                return "Cpf inválido";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: _cpfController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(10, 0, 0, 0),
                              labelText: "CPF",
                              hintStyle: const TextStyle(
                                color: Colors.black87,
                              ),
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
                            height: 15,
                          ),
                          TextFormField(
                            validator: (str) {
                              if (str == null) {
                                return "Por favor digite sua senha";
                              } else if (str.length < 4) {
                                return "Senha muito curta";
                              } else {
                                return null;
                              }
                            },
                            focusNode: focusNode4,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(10, 0, 0, 0),
                              labelText: "Password",
                              hintStyle: const TextStyle(
                                color: Colors.black87,
                              ),
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
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        checkbox,
                        Text(
                          'Aceito os termos de uso!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * .8, 50),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                checked == true) {
                              String name = _nameController.text;
                              String email = _emailController.text;
                              String cpf = _cpfController.text;
                              String password = _passwordController.text;
                              submit(name, email, cpf, password);
                            }
                          },
                          child: const Text(
                            'CRIAR CONTA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Platform.isIOS ? 35 : 20),
              child: IconButton(
                onPressed: () => _start(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
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
