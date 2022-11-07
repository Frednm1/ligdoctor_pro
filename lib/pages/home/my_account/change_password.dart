import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/routes.dart';
import '../../splash_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _cnewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(10, 0, 0, 0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  'assets/images/default-bg.png',
                ),
              ),
            ),
            SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 180,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Digite sua nova senha ',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _newPasswordController,
                              obscureText: true,
                              validator: (str) {
                                if (str == null || str == '') {
                                  return 'Por favor preencha o campo';
                                } else {
                                  return null;
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(10, 0, 0, 0),
                                labelStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                labelText: 'Nova senha...',
                                alignLabelWithHint: true,
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
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Confirme sua nova senha ',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              controller: _cnewPasswordController,
                              validator: (str) {
                                if (str == null || str == '') {
                                  return 'Por favor preencha o campo';
                                } else {
                                  return null;
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(10, 0, 0, 0),
                                labelStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                labelText: 'Nova senha...',
                                alignLabelWithHint: true,
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
                              height: 60,
                            ),
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
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen()));
                                  submit(
                                    _passwordController.text,
                                    _newPasswordController.text,
                                    _cnewPasswordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'Salvar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<Widget>(
                    future: userAvatar(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      } else {
                        return const SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Platform.isIOS ? 35 : 20),
              child: IconButton(
                onPressed: () => _returnUserPage(context),
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

  Future<Widget> userAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: FittedBox(
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(prefs.getString('iconAvatar')!),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            prefs.getString('name')!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(31, 59, 98, 1),
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ),
      ],
    );
  }

  submit(String password, String newPassword, String cnewPassword) async {
    if (newPassword != cnewPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Confirme sua senha corretamente",
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
    } else if (password == newPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "A nova senha não pode ser igual a atual",
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
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.https(
          'sandbox-api.excellencemedical.com.br', '/api/v1/user/update/1920');
      Map<String, String> header = {
        "Authorization": "Bearer ${prefs.getString("token")}",
      };
      var response = await http.post(url, headers: header, body: {
        "password": newPassword,
        "c_password": cnewPassword,
      });
      if (response.statusCode == 200) {
        if (response.body.contains("true")) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Senha alterada com sucesso",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _returnUserPage(context);
                  },
                  child: const Text('OK'),
                )
              ],
            ),
          );
        }
      }
    }
  }
}

_returnUserPage(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.userPage);
}
