import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/user_data_model.dart';

class Autentication {
  Future<bool> callCheck() {
    return _userCheck();
  }

  Future<bool> firstAccess() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isFirstAccess = prefs.getBool("firstAccess");
    if (isFirstAccess != false) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _userCheck() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var url =
          Uri.https('sandbox-api.excellencemedical.com.br', '/api/v1/getUser');

      var token = prefs.getString("token");
      if (token == null) {
        return false;
      }
      String bearerToken = "Bearer $token";
      Map<String, String> header = {
        "Authorization": bearerToken,
      };
      var responseGetUser = await http.post(url, headers: header);
      var dataGetUser =
          UserDataModel.fromJson(jsonDecode(responseGetUser.body));
      if (dataGetUser.success == true) {
        await prefs.setBool("firstAccess", false);

        _reloadInfo(dataGetUser);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  _reloadInfo(UserDataModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    await prefs.remove('avatar');
    if (data.user?.business?.id != null) {
      await prefs.setInt("businessId", data.user!.business!.id!);
    }
    if (data.user?.customer?.id != null) {
      await prefs.setInt("customerId", data.user!.customer!.id!);
    }
    if (data.user?.mobile != null) {
      await prefs.setString("mobile", data.user!.mobile);
    }
    if (data.user?.sex != null) {
      await prefs.setString("gender", data.user!.sex);
    }
    if (data.user?.birthday != null) {
      await prefs.setString("birthDate", data.user!.birthday);
    }
    if (data.user?.customer?.customerId != null) {
      await prefs.setString("customer_id", data.user!.customer?.customerId);
    }
    if (data.user?.avatar == null) {
      await prefs.setString('iconAvatar',
          'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg');
    } else {
      await prefs.setString("iconAvatar", data.user?.avatar);
    }
    if (data.user?.customer?.service?.model != null) {
      await prefs.setString("plan", data.user!.customer!.service!.model);
    } else {
      await prefs.setString("plan", '');
    }
    await prefs.setString("name", data.user!.name);
    await prefs.setString("email", data.user!.email);
    await prefs.setInt("id", data.user!.id!);
    await prefs.setString("cpf", data.user!.cpf);
    if (data.user?.customer?.service?.dependentes == null) {
      await prefs.setInt("dependents", 0);
    } else {
      await prefs.setInt(
          "dependents", data.user!.customer!.service!.dependentes!);
    }
    //set user
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    var refData = await ref.child('users').get();
    var userExist = refData.children.where((element) => element
        .child('_id')
        .value
        .toString()
        .contains(prefs.getInt('id').toString()));
    if (userExist.isNotEmpty) {
      await userExist.first.ref.remove();

      ref.child('users').push().set({
        "_id": prefs.getInt('id').toString(),
        "avatar": prefs.getString('iconAvatar'),
        "name": prefs.getString('name'),
      });
    } else {
      ref.child('users').push().set({
        "_id": prefs.getInt('id').toString(),
        "avatar": prefs.getString('iconAvatar'),
        "name": prefs.getString('name'),
      });
    }
  }
}
