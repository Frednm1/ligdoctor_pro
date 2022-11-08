import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ligdoctor_pro/models/teleconsults_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/routes.dart';

class Teleconsults extends StatefulWidget {
  const Teleconsults({super.key});

  @override
  State<Teleconsults> createState() => _TeleconsultsState();
}

class _TeleconsultsState extends State<Teleconsults> {
  String dropDownValue = 'Selecione';

  List<bool> buttons = [false, false, false, false, false, false];
  List<String> buttonsData = [
    'Atendido e resolvido',
    'Atendido e solicitado exames',
    'Atendido encaminhado à consulta presencial',
    'Atendimento suspeito',
    'Atendimento intermediado por responsável',
    'Atendido e encaminhado ao serviço de emergência',
  ];
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
          future: loadList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Teleconsultas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: snapshot.data!,
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<Widget> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('sandbox-api.excellencemedical.com.br',
        '/api/v1/meeting/list/${prefs.getInt('id')}');
    var response = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString("token")}"});
    var data = TeleconsultsModel.fromJson(jsonDecode(response.body));
    if (data.meetings?.length == 0) {
      return Column(
        children: const [
          Text(
            'Ops...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(31, 59, 98, 1),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Parece que você não tem consultas no momento',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(31, 59, 98, 1),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: data.meetings!.length,
      itemBuilder: (context, i) {
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
              ))),
          child: Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(data
                        .meetings![i].customer?.avatar?.file ??
                    'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      data.meetings![i].customer!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                        "${data.meetings![i].createdAt!.split(' ').first.split('-').last}/${data.meetings![i].createdAt!.split(' ').first.split('-').elementAt(1)}/${data.meetings![i].createdAt!.split(' ').first.split('-').first} às ${data.meetings![i].createdAt!.split(' ').last.split(':').first}:${data.meetings![i].createdAt!.split(' ').last.split(':').elementAt(1)}")
                  ],
                ),
              ),
              const Spacer(),
              data.meetings![i].status == 'waiting'
                  ? Row(children: [
                      IconButton(
                        onPressed: () =>
                            alterStatus('accepted', data.meetings![i].id!),
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Atenção'),
                                content: const Text(
                                    'Tem certeza que deseja cancelar a teleconsulta ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      alterStatus(
                                          'cancel', data.meetings![i].id!);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Voltar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ])
                  : data.meetings![i].status == "accept"
                      ? ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: ((context, changeState) {
                                    return Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'No atendimento houve',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  31, 59, 98, 1)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .1),
                                          child: DropdownButtonFormField(
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                            ),
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color:
                                                  Color.fromRGBO(31, 59, 98, 1),
                                              size: 30,
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: null,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: const Color.fromRGBO(
                                                  233, 233, 233, 1),
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'Selecione',
                                                child: Text(
                                                  'Selecione',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        31, 59, 98, 1),
                                                  ),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Troca de receita',
                                                child: Text(
                                                  'Troca de receita',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        31, 59, 98, 1),
                                                  ),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Orientação',
                                                child: Text(
                                                  'Orientação',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        31, 59, 98, 1),
                                                  ),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Consulta',
                                                child: Text(
                                                  'Consulta',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        31, 59, 98, 1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            value: dropDownValue,
                                            onChanged: (str) {
                                              setState(
                                                () {
                                                  dropDownValue = str!;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text(
                                          'Como foi a consulta?',
                                          style: TextStyle(
                                              fontSize: 24,
                                              height: 0,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  31, 59, 98, 1)),
                                        ),
                                        const Text(
                                          'Selecione um ou mais itens',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  31, 59, 98, 1)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            itemCount: 6,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .1),
                                            clipBehavior: Clip.antiAlias,
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    changeState(() {
                                                      buttons[i] = !buttons[i];
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor: buttons[
                                                                i] ==
                                                            false
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    buttonsData[i],
                                                    style: TextStyle(
                                                      color: buttons[i] == false
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (dropDownValue == 'Selecione' ||
                                                !buttons.contains(true)) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Preencha todos os campos'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text('OK'),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              List<String> list = [];
                                              for (int i = 0; i < 6; i++) {
                                                if (buttons[i] == true) {
                                                  list.add(buttonsData[i]);
                                                }
                                              }
                                              endTeleconsult(
                                                  data.meetings![i].id!, list);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .8,
                                                50),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: const Text(
                                            'Finalizar consulta',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    );
                                  }),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text(
                            'Finalizar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : data.meetings![i].status == "ending"
                          ? const Text(
                              'finalizada',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )
                          : const Text(
                              'cancelada',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
            ],
          ),
        );
      },
    );
  }

  endTeleconsult(int id, List<String> buttons) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https(
        'sandbox-api.excellencemedical.com.br', '/api/v1/meeting/alterStatus');
    var header = {"Authorization": "Bearer ${prefs.getString("token")}"};
    var list = jsonEncode(buttons);

    var response = await http.post(url, headers: header, body: {
      "status": "ending",
      "id": id.toString(),
      "informations": list,
    }).then(
      (value) {
        print(value.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cancelado'),
              content: const Text('Consulta cancelada com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () => _home(context),
                  child: const Text("OK"),
                )
              ],
            );
          },
        );
      },
    );
  }

  alterStatus(String status, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https(
        'sandbox-api.excellencemedical.com.br', '/api/v1/meeting/alterStatus');
    var header = {"Authorization": "Bearer ${prefs.getString("token")}"};

    await http.post(url, headers: header, body: {
      "status": status,
      "id": id.toString(),
    }).then(
      (_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cancelado'),
              content: const Text('Consulta cancelada com sucesso!'),
              actions: [
                TextButton(
                    onPressed: () => _home(context), child: const Text("OK"))
              ],
            );
          },
        );
      },
    );
  }
}

_home(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.home);
}
