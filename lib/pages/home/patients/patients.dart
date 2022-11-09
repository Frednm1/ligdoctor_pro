import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ligdoctor_pro/models/patients_model.dart';
import 'package:ligdoctor_pro/pages/home/patients/patient_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Pacientes',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 26,
              height: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<Widget>(
              future: loadPatients(),
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
          ),
        ],
      ),
    );
  }

  Future<Widget> loadPatients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('sandbox-api.excellencemedical.com.br',
        '/api/v1/patients/${prefs.getInt('id')}');
    var response = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString("token")}"});
    var data = PatientsModel.fromJson(jsonDecode(response.body));
    return ListView.builder(
      itemCount: data.patients!.length,
      itemBuilder: (context, i) {
        String avatar = data.patients?[i].customer?.avatar?.file ??
            'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
        String patientData =
            '${data.patients![i].createdAt!.split(' ').first.split('-').last}/${data.patients![i].createdAt!.split(' ').first.split('-')[1]}/${data.patients![i].createdAt!.split(' ').first.split('-').first}';
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            border: const Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                foregroundImage: NetworkImage(avatar),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.patients![i].customer!.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(patientData),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () =>
                    _patientChart(context, data.patients![i].business!.id!),
                icon: const Icon(
                  Icons.library_books_rounded,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  _patientChart(BuildContext context, int patientId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PatientChart(id: patientId);
    }));
  }
}
