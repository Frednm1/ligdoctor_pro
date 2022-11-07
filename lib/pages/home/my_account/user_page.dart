import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../components/submit_button_user_page.dart';
import '../../../components/user_page_button.dart';
import '../../../services/auth_service.dart';
import '../../../utils/routes.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  File? photoFile;
  bool havePhoto = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(10, 0, 0, 0),
            child: Image.asset(
              'assets/images/default-bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Platform.isIOS ? 35 : 20),
            child: IconButton(
              onPressed: () => _returnHomePage(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  havePhoto
                      ? FutureBuilder<Widget>(
                          future: preVisualizor(),
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
                        )
                      : FutureBuilder<Widget>(
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
                  const SizedBox(
                    height: 40,
                  ),
                  UserPageButton(
                    userButtonIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    userButtonText: 'Meus Dados',
                    func: () => _userData(context),
                  ),
                  UserPageButton(
                    func: () => _editLocation(context),
                    userButtonIcon: const Icon(
                      Icons.location_pin,
                      color: Colors.white,
                    ),
                    userButtonText: 'Alterar Endereço',
                  ),
                  UserPageButton(
                    func: () => _changePassword(context),
                    userButtonIcon: const Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    userButtonText: 'Alterar senha',
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * .35, top: 0),
                    child: TextButton(
                      child: Text(
                        'Cancelar minha assinatura',
                        style: TextStyle(
                          color: Colors.amber[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        _support(context);
                      },
                    ),
                  ),
                  SubmitButtonUserPage(
                    func: () {
                      _logout(context);
                    },
                    text: 'Sair',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  askPermission() async {
    await [Permission.camera, Permission.microphone].request();
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
            child: InkWell(
              onTap: () {
                takePicture();
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        prefs.getString("iconAvatar")!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, left: 50),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Color.fromRGBO(31, 59, 98, 1),
                    ),
                  ),
                ],
              ),
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

  Future<Widget> preVisualizor() async {
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
            child: InkWell(
              onTap: () {
                takePicture();
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        photoFile!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, left: 50),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Color.fromRGBO(31, 59, 98, 1),
                    ),
                  ),
                ],
              ),
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

  Future<bool> haveDependents() async {
    await Autentication().callCheck();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("dependents") == 0) {
      return false;
    } else {
      return true;
    }
  }

  takePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ImagePicker imagePicker = ImagePicker();
    final XFile? photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
    );
    var url = Uri.https(
        'sandbox-api.excellencemedical.com.br', '/api/v1/user/savePhoto');

    if (photo != null) {
      final bytes = await photo.readAsBytes();
      String pre = 'data:image/jpeg;base64,';
      String imageString;
      imageString = '$pre${base64Encode(bytes)}';
      var response = await http.post(url, headers: {
        "Authorization": "Bearer ${prefs.getString("token")}"
      }, body: {
        "user_id": prefs.getInt('id').toString(),
        "type": 'avatar',
        "photo": imageString,
      });
      if (response.statusCode == 200) {
        setState(() {
          photoFile = File(photo.path);
          havePhoto = true;
        });
      }
      Autentication().callCheck();
    } else {
      return;
    }
  }

  _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("id");
    await prefs.remove("name");
    await prefs.remove("dependents");
    await prefs.remove("plan");
    await prefs.remove("email");
    await prefs.remove("iconAvatar");
    await prefs.remove("cpf");
    await prefs.remove("customer_id");
    await prefs.remove("customerId");
    await prefs.remove('businessId');
    await prefs.remove('plan_id');
    await prefs.remove('mobile');
    await prefs.remove('birthDate');
    Navigator.of(context).pushReplacementNamed(Routes.loading);
  }

  _support(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.support);
  }

  _returnHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  _changePassword(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.changePassword);
  }

  _userData(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.userData);
  }

  _editLocation(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.editLocation);
  }
}
