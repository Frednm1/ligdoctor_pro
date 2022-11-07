import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../services/auth_service.dart';
import '../../../utils/routes.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

_reload(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.loading);
}

class _UserDataState extends State<UserData> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _cellphoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _rgController = TextEditingController();
  final _birthDateController = TextEditingController();

  String? _dropdownValue;
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  Future<Map<String, dynamic>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> map = {
      "cpf": prefs.getString("cpf"),
      "name": prefs.getString("name"),
      "email": prefs.getString("email"),
    };
    if (prefs.getString("mobile") != null) {
      Map<String, dynamic> cellphone = {"mobile": prefs.getString("mobile")};
      map.addAll(cellphone);
    }
    if (prefs.getString("telephone") != null) {
      Map<String, dynamic> telephone = {
        "telephone": prefs.getString("telephone")
      };
      map.addAll(telephone);
    }
    if (prefs.getString("birthDate") != null) {
      String years = prefs.getString("birthDate")!;
      Map<String, dynamic> birthDate = {
        "birthDate": years,
      };
      map.addAll(birthDate);
    }
    if (prefs.getString("rg") != null) {
      Map<String, dynamic> rg = {
        "rg": prefs.getString("rg"),
      };
      map.addAll(rg);
    }
    if (prefs.getString("gender") != null) {
      Map<String, dynamic> gender = {
        "gender": prefs.getString("gender") == 'Masculino' ||
                prefs.getString("gender") == 'male'
            ? "Masculino"
            : "Feminino",
      };
      map.addAll(gender);
    }

    return map;
  }

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
              child: Image.asset(
                'assets/images/default-bg.png',
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
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
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: loadData(),
                          builder: (context, snapshot) {
                            var data = snapshot.data;

                            return Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 120,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Nome ',
                                        style: textStyle,
                                      ),
                                      request
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (str) {
                                      if (str == '' && data?['name'] == null) {
                                        return 'por favor preencha o campo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _nameController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText:
                                          data?['name'] ?? 'Digite seu nome...',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'Email ',
                                        style: textStyle,
                                      ),
                                      request
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (str) {
                                      if (str == '' && data?['email'] == null) {
                                        return 'por favor preencha o campo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _emailController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText: data?['email'] ??
                                          'Digite seu email...',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'Celular ',
                                        style: textStyle,
                                      ),
                                      request
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (str) {
                                      if (str == '' &&
                                          data?['mobile'] == null) {
                                        return 'por favor preencha o campo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _cellphoneController,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter(),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText: data?['mobile'] ??
                                          'Ex: (dd) 00000-0000',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'Telefone ',
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: _telephoneController,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter(),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText: data?['telephone'] ??
                                          'Ex: (dd) 0000-0000',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'CPF ',
                                        style: textStyle,
                                      ),
                                      request
                                    ],
                                  ),
                                  TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CpfInputFormatter(),
                                    ],
                                    keyboardType: TextInputType.text,
                                    validator: (str) {
                                      if (str == '' && data?['cpf'] == null) {
                                        return 'por favor preencha o campo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _cpfController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText:
                                          data?['cpf'] ?? 'Digite seu cpf...',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'RG ',
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    controller: _rgController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText:
                                          data?['rg'] ?? 'Digite seu RG...',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'Data de nasc',
                                        style: textStyle,
                                      ),
                                      request
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (str) {
                                      if (str == '' &&
                                          data?['birthDate'] == null) {
                                        return 'por favor preencha o campo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _birthDateController,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      DataInputFormatter(),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(10, 0, 0, 0),
                                      hintStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      hintText:
                                          data?['birthDate'] ?? 'dd/mm/aaaa',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
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
                                        'Gênero ',
                                        style: textStyle,
                                      ),
                                      request
                                    ],
                                  ),
                                  data?['gender'] == null
                                      ? SizedBox(
                                          height: 55,
                                          child: DropdownButtonFormField(
                                            validator: (value) {
                                              if (value != "Masculino" &&
                                                  value != "Feminino") {
                                                return "Por favor preencha o campo";
                                              } else {
                                                return null;
                                              }
                                            },
                                            dropdownColor: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15),
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            iconSize: 20,
                                            icon: const Icon(Icons
                                                .keyboard_arrow_down_sharp),
                                            hint: const Text('Selecione'),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(172, 0, 0, 0),
                                              fontSize: 16,
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                value: "Masculino",
                                                child: Text('Masculino'),
                                              ),
                                              DropdownMenuItem(
                                                value: "Feminino",
                                                child: Text('Feminino'),
                                              ),
                                            ],
                                            value: _dropdownValue,
                                            onChanged: dropdownCallback,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 55,
                                          child: DropdownButtonFormField(
                                            validator: (value) {
                                              if (value != "Masculino" &&
                                                  value != "Feminino") {
                                                return "Por favor preencha o campo";
                                              } else {
                                                return null;
                                              }
                                            },
                                            dropdownColor: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            iconSize: 20,
                                            icon: const Icon(Icons
                                                .keyboard_arrow_down_sharp),
                                            hint: const Text('Selecione'),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(172, 0, 0, 0),
                                              fontSize: 16,
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                value: "Masculino",
                                                child: Text('Masculino'),
                                              ),
                                              DropdownMenuItem(
                                                value: "Feminino",
                                                child: Text('Feminino'),
                                              ),
                                            ],
                                            value: data?["gender"].toString(),
                                            onChanged: dropdownCallback,
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 30,
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
                                          MediaQuery.of(context).size.width *
                                              .8,
                                          50),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        String name = _nameController.text == ''
                                            ? data!['name']
                                            : _nameController.text;
                                        String email =
                                            _emailController.text == ''
                                                ? data!['email']
                                                : _emailController.text;
                                        String cellphone =
                                            _cellphoneController.text == ''
                                                ? data!['mobile']
                                                : _cellphoneController.text;
                                        String? telephone =
                                            _telephoneController.text == ''
                                                ? data!['telephone']
                                                : _telephoneController;
                                        String cpf = _cpfController.text == ''
                                            ? data!['cpf']
                                            : _cpfController.text;
                                        String? rg = _rgController.text == ''
                                            ? data!['rg']
                                            : _rgController.text;
                                        String birthDate =
                                            _birthDateController.text == ''
                                                ? data!['birthDate']
                                                : _birthDateController.text;
                                        String gender =
                                            _dropdownValue ?? data!['gender'];

                                        submit(
                                            name,
                                            email,
                                            cellphone,
                                            telephone,
                                            cpf,
                                            rg,
                                            birthDate,
                                            gender);
                                        _reload(context);
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
                            );
                          },
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

  _returnUserPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.userPage);
  }

  submit(String name, String email, String cellphone, String? telephone,
      String cpf, String? rg, String birthDate, String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('sandbox-api.excellencemedical.com.br',
        '/api/v1/user/update/${prefs.getInt("id")}');
    var response = await http.post(url, headers: {
      "Authorization": "Bearer ${prefs.getString("token")}"
    }, body: {
      "name": name,
      "email": email,
      "mobile": cellphone,
      "phone": telephone ?? '',
      "cpf": cpf,
      "rg": rg ?? '',
      "birthday": birthDate,
      "sex": gender,
    });
    Autentication().callCheck();
  }

  Text request = const Text(
    ' (obrigatório)!',
    style: TextStyle(
      color: Colors.red,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  );
}
