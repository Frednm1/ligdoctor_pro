import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ligdoctor_pro/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Financial extends StatefulWidget {
  const Financial({super.key});

  @override
  State<Financial> createState() => _FinancialState();
}

class _FinancialState extends State<Financial> {
  int dropDownValue1 = DateTime.now().month;
  int dropDownValue2 = DateTime.now().year;
  TextStyle dropDownStyle =
      const TextStyle(fontSize: 13, color: Color.fromRGBO(31, 59, 98, 1));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
            body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1),
                child: snapshot.data!),
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }

  Future<Widget> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String month;
    if (dropDownValue1 > 9) {
      month = dropDownValue1.toString();
    } else {
      month = '0$dropDownValue1';
    }
    var url = Uri.https('sandbox-api.excellencemedical.com.br',
        '/api/v1/finances/list/170/$dropDownValue2-$month');
    print(url);
    var response = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"});
    var data = jsonDecode(response.body);
    int value = 0;
    int length = data['finances'].length;
    if (data['totalMonth']['total'] != null) {
      value = int.parse(data['totalMonth']['total']);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Finanças',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(31, 59, 98, 1),
            fontSize: 28,
            height: 3,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Selecione a data desejada'),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromRGBO(233, 233, 233, 1),
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width * .35, 50),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Janeiro',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(
                    'Fevereiro',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text(
                    'Março',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text('Abril', style: dropDownStyle),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text(
                    'Maio',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 6,
                  child: Text(
                    'Junho',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 7,
                  child: Text(
                    'Julho',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 8,
                  child: Text(
                    'Agosto',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 9,
                  child: Text(
                    'Setembro',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text(
                    'Outubro',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 11,
                  child: Text(
                    'Novembro',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 12,
                  child: Text(
                    'Dezembro',
                    style: dropDownStyle,
                  ),
                ),
              ],
              value: dropDownValue1,
              onChanged: (str) {
                setState(() {
                  dropDownValue1 = str!;
                });
                loadData();
              },
            ),
            Expanded(
              child: Container(),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromRGBO(233, 233, 233, 1),
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width * .35, 50),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 2020,
                  child: Text(
                    '2020',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 2021,
                  child: Text(
                    '2021',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 2022,
                  child: Text(
                    '2022',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 2023,
                  child: Text(
                    '2023',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 2024,
                  child: Text(
                    '2024',
                    style: dropDownStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: 2025,
                  child: Text(
                    '2025',
                    style: dropDownStyle,
                  ),
                ),
              ],
              value: dropDownValue2,
              onChanged: (str) {
                setState(() {
                  dropDownValue2 = str!;
                });
                loadData();
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Histórico de transações',
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.black12, width: 1),
          )),
        ),
        length == 0
            ? Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Ops...',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Parece que não houve \ntransações na data selecionada',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : Flexible(
                child: ListView.builder(
                  itemCount: length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    String transationTime =
                        '${data['finances'][index]['created_at'].toString().split(' ').first.split('-').last}/${data['finances'][index]['created_at'].toString().split(' ').first.split('-')[1]} às ${data['finances'][index]['created_at'].toString().split(' ').last.split(':').first}:${data['finances'][index]['created_at'].toString().split(' ').last.split(':')[1]}';
                    return Container(
                      height: 80,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(233, 233, 233, 1),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data['finances'][index]['customer']['name']}',
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(transationTime)
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'R\$ ${(data['finances'][index]['value'] / 100).toString().replaceAll('.', ',')}0'),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.black12, width: 1),
          )),
        ),
        const Text(
          'Total',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(31, 59, 98, 1),
            fontSize: 28,
            height: 1.2,
            fontWeight: FontWeight.w500,
          ),
        ),
        Card(
          elevation: 0.5,
          color: const Color.fromRGBO(233, 233, 233, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              'R\$ ${(value / 100).toString().replaceAll('.', ',')}0',
              style: const TextStyle(
                color: Color.fromRGBO(31, 59, 98, 1),
                fontSize: 36,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
