// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ligdoctor_pro/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/routes.dart';
import '../../../components/message_bubble.dart';
import '../../splash_screen.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  String channelId;
  String patientId;
  Chat({
    Key? key,
    required this.channelId,
    required this.patientId,
  }) : super(key: key);
  @override
  State<Chat> createState() => _ChatState();
}

_returnHome(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.home);
}

class _ChatState extends State<Chat> {
  late String messageText;

  List<NewChatClassModel> list = [];
  final _controller = TextEditingController();
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          title: SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: FutureBuilder<Widget>(
              future: patientAvatar(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  print(snapshot.error);
                  return Container();
                }
              },
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
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
                              child: const Text('Voltar'),
                            ),
                            TextButton(
                              onPressed: () {
                                _closeChannel();
                                Navigator.pop(context);
                              },
                              child: const Text('Sim'),
                            ),
                          ],
                          content: const Text(
                              'Tem certeza que deseja encerrar o Chat?'),
                        );
                      });
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ))
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _returnHome(context),
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black12,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<DatabaseEvent>(
                    stream: FirebaseDatabase.instance.ref('messages').onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.snapshot;
                        list.clear();
                        var msgs = data.children.where((element) => element
                            .child('channelId')
                            .value
                            .toString()
                            .contains(widget.channelId));

                        for (var element in msgs) {
                          list.add(
                            NewChatClassModel.fromJson(
                              jsonDecode(
                                jsonEncode(element.value),
                              ),
                            ),
                          );
                        }
                        list = list.reversed.toList();
                        return ListView.builder(
                            itemCount: list.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MessageBubble(
                                  message: list[index].text!,
                                  belongsToCurrentUser:
                                      list[index].belongsToPatient!,
                                ),
                              );
                            });
                      } else {
                        return const SplashScreen();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            autocorrect: true,
                            selectionHeightStyle: BoxHeightStyle.tight,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              hintText: "Digite sua mensagem",
                              contentPadding:
                                  const EdgeInsets.only(top: 5, left: 15),
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  messageText = _controller.text;
                                });
                                if (messageText.trim().isNotEmpty) {
                                  createMessage(messageText, widget.channelId);
                                  clearInput();
                                }
                              },
                              icon: const Icon(Icons.send),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _closeChannel() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('channels/${widget.channelId}');
    await ref.child('status').set("inactive");
  }

  Future<Widget> patientAvatar() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('users');
    var users = await ref.get();
    var user = users.children.where(
        (element) => element.child('_id').value.toString() == widget.patientId);
    String avatar =
        'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg';
    if (user.first.child('avatar').exists) {
      avatar = user.first.child('avatar').value.toString();
    }

    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              avatar,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 5,
          child: Text(
            user.first.child('name').value.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(31, 59, 98, 1),
              fontWeight: FontWeight.bold,
            ),
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  clearInput() {
    FocusScope.of(context).unfocus();
    _controller.clear();
  }

  createMessage(String msg, String channelId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('/messages');
    final newPost = ref.push().key;
    ref.child('/$newPost').set(
      {
        "_id": DateTime.now().microsecondsSinceEpoch,
        "belongsToPatient": false,
        "channelId": widget.channelId,
        "createdAt": DateTime.now().microsecondsSinceEpoch,
        "text": msg,
      },
    );
    updateChannel();
  }

  updateChannel() async {
    DatabaseReference channelRef = FirebaseDatabase.instance.ref();
    var messages = await channelRef
        .child("channels/${widget.channelId}/newMessageDoctor")
        .get();
    var value = jsonDecode(messages.value!.toString());
    int messagesValue = value as int;
    messagesValue = messagesValue + 1;
    await channelRef
        .child("channels/${widget.channelId}/newMessageDoctor")
        .set(messagesValue.toString());
    await channelRef.child("channels/${widget.channelId}/newMessage").set(0);
  }
}

class NewChatClassModel {
  int? createdAt;
  dynamic system;
  dynamic belongsToPatient;
  dynamic iId;
  String? text;
  String? channelId;

  NewChatClassModel(
      {this.createdAt,
      this.system,
      this.belongsToPatient,
      this.iId,
      this.text,
      this.channelId});

  NewChatClassModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    system = json['system'] ?? false;
    belongsToPatient = json['belongsToPatient'] ?? false;
    iId = json['_id'];
    text = json['text'];
    channelId = json['channelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['system'] = system;
    data['belongsToPatient'] = belongsToPatient;
    data['_id'] = iId;
    data['text'] = text;
    data['channelId'] = channelId;
    return data;
  }
}
