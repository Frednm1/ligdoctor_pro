// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ligdoctor_pro/pages/home/patients/archives.dart';
import 'package:ligdoctor_pro/pages/home/patients/registers.dart';
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
        },
      ),
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

    //Avatar
    String avatar;
    if (data['business']['customer']['avatar'] == null) {
      avatar =
          'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
    } else {
      avatar = data['business']['customer']['avatar']['file'] ??
          'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
    }
    //Peso e altura
    String weightHeight;
    if (data['business']['weight_height'] == null) {
      weightHeight = 'Não informado';
    } else {
      if (data['business']['weight_height'].toString().split(' ').length > 2) {
        weightHeight = data['business']['weight_height'].toString();
      } else {
        weightHeight =
            '${data['business']['weight_height'].toString().split(' ').first} kg, ${data['business']['weight_height'].toString().split(' ').last} cm';
      }
    }
    String years;
    if (data['business']['age'] == null) {
      years = 'Não informado';
    } else {
      if (!data['business']['age'].toString().contains('/')) {
        years = 'Não informado';
      } else {
        years = AgeCalculator.age(DateTime.utc(
          int.parse(data['business']['age'].toString().split('/').last),
          int.parse(data['business']['age'].toString().split('/')[1]),
          int.parse(data['business']['age'].toString().split('/').first),
        )).years.toString();
      }
    }

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
                  ),
                ),
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
          flex: 3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text(
                      'Idade: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      years.toString(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Peso e altura: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(weightHeight)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Doenças crônicas? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data['business']['chronic_diseases'] ??
                        'Não informado'),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Alguma alergia? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data['business']['alergy'] ?? 'Não informado'),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: [
                    const Text(
                      'Faz uso de medicamento contínuo? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data['business']['medicine'] ?? 'Não informado'),
                  ],
                ),
                const Spacer(),
                TextField(
                  autocorrect: true,
                  maxLines: 6,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    hintText:
                        'Digite algo sobre o atendimento feito ao paciente...',
                    fillColor: const Color.fromRGBO(233, 233, 233, 1),
                    contentPadding: null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * .35, 50),
                        backgroundColor: const Color.fromRGBO(31, 59, 98, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _registers(context, data),
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * .35, 50),
                        backgroundColor: const Color.fromRGBO(31, 59, 98, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Ver registros',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => _archives(context, data),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * .8, 50),
                    backgroundColor: const Color.fromRGBO(31, 59, 98, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Arquivos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

_registers(BuildContext context, var data) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Registers(data: data);
  }));
}

_archives(BuildContext context, var data) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return Archives(
          data: data,
        );
      },
    ),
  );
}
