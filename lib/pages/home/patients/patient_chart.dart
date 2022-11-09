// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ligdoctor_pro/models/patient_chart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientChart extends StatefulWidget {
  int id;
  PatientChart({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<PatientChart> createState() => _PatientChartState();
}

class _PatientChartState extends State<PatientChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo-escura.png',
        ),
        toolbarHeight: 70,
        leadingWidth: 80,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Widget>(
          future: loadChart(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<Widget> loadChart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('sandbox-api.excellencemedical.com.br',
        '/api/v1/business/${widget.id}/${prefs.getInt('id')}');
    var response = await http.get(url, headers: {
      "Authorization": "Bearer ${prefs.getString("token")}",
    });
    var data = jsonDecode(response.body);
    String avatar;
    if (data['business']['customer']['avatar'] == null) {
      avatar = data['business']['customer']['avatar'] ??
          'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
    } else {
      avatar = data['business']['customer']['avatar']['file'] ??
          'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
    }
    var years = AgeCalculator.age(DateTime.utc(
      int.parse(data['business']['age'].toString().split('/').last),
      int.parse(data['business']['age'].toString().split('/')[1]),
      int.parse(data['business']['age'].toString().split('/').first),
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(avatar),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Prontuário do paciente:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    data['business']['customer']['name'],
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(data['business']['customer']['email']),
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Idade:'),
                    Text(years.years.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Peso e altura:'),
                    Text(
                        '${data['business']['weight_height'].toString().split(' ').first} kg, ${data['business']['weight_height'].toString().split(' ').last} cm')
                  ],
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(color: Colors.red),
        ),
      ],
    );
  }
}
