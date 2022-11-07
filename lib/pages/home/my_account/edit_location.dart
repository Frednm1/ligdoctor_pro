import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_data_model.dart';
import '../../../utils/routes.dart';

class EditLocation extends StatefulWidget {
  const EditLocation({Key? key}) : super(key: key);

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _districtController = TextEditingController();
  final _complementController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  Future<Map<String, dynamic>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        Uri.https('sandbox-api.excellencemedical.com.br', '/api/v1/getUser');
    var response = await http.post(url,
        headers: {"Authorization": "Bearer ${prefs.getString("token")}"});
    var data = UserDataModel.fromJson(jsonDecode(response.body));
    Map<String, dynamic> map = {
      "cep": data.user?.zipcode,
      "rua": data.user?.street,
      "numero": data.user?.streetNumber,
      "bairro": data.user?.neighborhood,
      "complemento": data.user?.complement,
      "cidade": data.user?.city,
      "estado": data.user?.state,
    };
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
                    margin: const EdgeInsets.only(top: 70),
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
                                      'CEP ',
                                      style: textStyle,
                                    ),
                                    request
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _cepController,
                                  onChanged: (value) {
                                    searchCep(value);
                                  },
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CepInputFormatter(),
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
                                        data?['cep'] ?? 'Ex: 12.345-678...',
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
                                      'Rua ',
                                      style: textStyle,
                                    ),
                                    request
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _streetController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(10, 0, 0, 0),
                                    hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    hintText: data?['rua'] ?? 'Ex: rua 123...',
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
                                      'Número ',
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _numberController,
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
                                        data?['numero'] ?? 'Ex: n° 123...',
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
                                      'Bairro ',
                                      style: textStyle,
                                    ),
                                    request
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _districtController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(10, 0, 0, 0),
                                    hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    hintText: data?['bairro'] ??
                                        'Ex: Bairro Independência...',
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
                                      'Complemento ',
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _complementController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(10, 0, 0, 0),
                                    hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    hintText: data?['complemento'] ??
                                        'Ex: Ap.102 torre 1...',
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
                                      'Cidade ',
                                      style: textStyle,
                                    ),
                                    request
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(10, 0, 0, 0),
                                    hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    hintText:
                                        data?['cidade'] ?? 'Ex: Goiânia...',
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
                                      'Estado(UF) ',
                                      style: textStyle,
                                    ),
                                    request
                                  ],
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _stateController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(10, 0, 0, 0),
                                    hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    hintText: data?['estado'] ?? 'Ex: Goiás...',
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
                                        MediaQuery.of(context).size.width * .8,
                                        50),
                                  ),
                                  onPressed: () {
                                    String? cep = _cepController.text;
                                    String? street = _streetController.text;
                                    String? number = _numberController.text;
                                    String? district = _districtController.text;
                                    String? complement =
                                        _complementController.text;
                                    String? city = _cityController.text;
                                    String? state = _stateController.text;
                                    _submit(cep, street, number, district,
                                        complement, city, state);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const SplashScreen()));
                                    _reload(context);
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

  Text request = const Text(
    ' (obrigatório)!',
    style: TextStyle(
      color: Colors.red,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  );
  searchCep(String cep) async {
    final viaCepSearchCep = ViaCepSearchCep();
    if (cep.length == 10) {
      final infoCepJSON = await viaCepSearchCep.searchInfoByCep(
          cep: cep.replaceAll('-', '').replaceAll('.', ''));
      var bairro = infoCepJSON.fold((l) => 'cep inválido', (r) => r.bairro);
      var rua = infoCepJSON.fold((l) => 'cep inválido', (r) => r.logradouro);
      var complemento =
          infoCepJSON.fold((l) => 'cep inválido', (r) => r.complemento);
      var cidade = infoCepJSON.fold((l) => 'cep inválido', (r) => r.localidade);
      var estado = infoCepJSON.fold((l) => 'cep inválido', (r) => r.uf);
      setState(() {
        _streetController.text = rua.toString();
        _districtController.text = bairro.toString();
        _complementController.text = complemento.toString();
        _cityController.text = cidade.toString();
        _stateController.text = estado.toString();
      });
    }
  }

  _submit(String? cep, String? street, String? number, String? district,
      String? complement, String? city, String? state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> body = {};

    if (cep != null && cep != '') {
      cep.replaceAll(".", "");
      cep.replaceAll("-", "");
      Map<String, String> cepMap = {
        "zipcode": cep,
      };
      body.addAll(cepMap);
    }
    if (street != null && street != '') {
      Map<String, String> streetMap = {
        "street": street,
      };
      body.addAll(streetMap);
    }
    if (number != null && number != '') {
      Map<String, String> numberMap = {
        "number": number,
      };
      body.addAll(numberMap);
    }
    if (district != null && district != '') {
      Map<String, String> districtMap = {
        "neighborhood": district,
      };
      body.addAll(districtMap);
    }
    if (complement != null && complement != '') {
      Map<String, String> complementMap = {
        "complement": complement,
      };
      body.addAll(complementMap);
    }
    if (city != null && city != '') {
      Map<String, String> cityMap = {
        "city": city,
      };
      body.addAll(cityMap);
    }
    if (state != null && state != '') {
      Map<String, String> stateMap = {
        "state": state,
      };
      body.addAll(stateMap);
    }
    var url = Uri.https('sandbox-api.excellencemedical.com.br',
        '/api/v1/user/update/${prefs.getInt('id')}');
    var response = await http.post(
      url,
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
      body: body,
    );
    var data = jsonDecode(response.body);
  }
}

_reload(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.loading);
}

_returnUserPage(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.userPage);
}
