// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Archives extends StatefulWidget {
  var data;
  Archives({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  State<Archives> createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  String _dropdownValue = 'Selecione';
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
          const Text(
            'Arquivos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              height: 2,
              color: Color.fromRGBO(31, 59, 98, 1),
            ),
          ),
          widget.data['business']['arquives'].isEmpty
              ? Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ops...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Parece que o paciente não tem nenhum arquivo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ))
              : Flexible(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: widget.data['business']['arquives'].length,
                    itemBuilder: (context, i) {
                      String avatar;
                      if (widget.data['business']['customer']['avatar'] ==
                          null) {
                        avatar = widget.data['business']['customer']
                                ['avatar'] ??
                            'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
                      } else {
                        avatar = widget.data['business']['customer']['avatar']
                                ['file'] ??
                            'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 70,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .1,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 50,
                              width: 50,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data['business']['arquives'][i]
                                          ['title'] ??
                                      'Receita médica',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${widget.data['business']['arquives'][i]['created_at'].toString().split(' ').first.split('-').last}/${widget.data['business']['arquives'][i]['created_at'].toString().split(' ').first.split('-')[1]}/${widget.data['business']['arquives'][i]['created_at'].toString().split(' ').first.split('-').first} às ${widget.data['business']['arquives'][i]['created_at'].toString().split(' ').last.split(':').first}:${widget.data['business']['arquives'][i]['created_at'].toString().split(' ').last.split(':')[1]}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.download,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            const Spacer(),
                            const Text('Selecione o tipo do arquivo'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(233, 233, 233, 1),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Selecione',
                                    child: Text('Selecione'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Receita médica',
                                    child: Text('Receita médica'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Pedido de exame',
                                    child: Text('Pedido de exame'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Atestado médico',
                                    child: Text('Atestado médico'),
                                  ),
                                ],
                                value: _dropdownValue,
                                onChanged: (str) {
                                  setState(() {
                                    _dropdownValue = str!;
                                  });
                                },
                              ),
                            ),
                            const Spacer(
                              flex: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_dropdownValue != 'Selecione') {
                                  sendFile();
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Atenção'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          )
                                        ],
                                        content: const Text(
                                          'Selecione o tipo do arquivo antes de envia-lo',
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * .8, 50),
                                backgroundColor:
                                    const Color.fromRGBO(31, 59, 98, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Enviar arquivo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * .35, 50),
                  backgroundColor: const Color.fromRGBO(31, 59, 98, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Enviar arquivo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  sendFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      var base64 = await file.readAsBytes();

      String fileString = base64Encode(base64);
      var url = Uri.https(
          'sandbox-api.excellencemedical.com.br', '/api/v1/business/saveFile');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${prefs.getString('token')}",
        },
        body: {
          "file": 'data:application/pdf;base64,$fileString',
          "user_id": prefs.getInt("id").toString(),
          "type": "prontuary",
          "title": _dropdownValue,
          "deal_id": widget.data['business']['id'].toString(),
        },
      );
      print(response.body);
    } else {
      // User canceled the picker
    }
  }
}
