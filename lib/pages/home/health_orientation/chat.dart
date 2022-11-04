// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/doctor_model.dart';
import '../../../../utils/routes.dart';
import '../../../components/message_bubble.dart';
import '../../splash_screen.dart';

class Chat extends StatefulWidget {
  String channelId;
  Chat({
    Key? key,
    required this.channelId,
  }) : super(key: key);
  @override
  State<Chat> createState() => _ChatState();
}

_returnHome(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(Routes.home);
}

class _ChatState extends State<Chat> {
  late String messageText;
  late String channelId;

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
            child: FutureBuilder(
              future: doctorAvatar(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return Container();
                }
              },
            ),
          ),
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
                  child: FutureBuilder<String>(
                      future: startChat(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String canal = snapshot.data!;
                          FirebaseDatabase.instance
                              .ref('channels/${snapshot.data}')
                              .onValue
                              .listen((event) {
                            if (event.snapshot
                                    .child('status')
                                    .value
                                    .toString() ==
                                'inactive') {
                              setState(() {
                                isActive = false;
                              });
                            }
                          });

                          return StreamBuilder<DatabaseEvent>(
                            stream: FirebaseDatabase.instance
                                .ref('messages')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.snapshot;
                                list.clear();
                                var msgs = data.children.where((element) =>
                                    element
                                        .child('channelId')
                                        .value
                                        .toString()
                                        .contains(canal));

                                msgs.forEach((element) {
                                  list.add(
                                    NewChatClassModel.fromJson(
                                      jsonDecode(
                                        jsonEncode(element.value),
                                      ),
                                    ),
                                  );
                                });
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
                          );
                        } else {
                          return const SplashScreen();
                        }
                      }),
                ),
                isActive
                    ? SizedBox(
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        messageText = _controller.text;
                                      });
                                      if (messageText.trim().isNotEmpty) {
                                        createMessage(messageText, channelId);
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
                        ))
                    : SizedBox(
                        height: 80,
                        child: Column(
                          children: [
                            const Text('A consulta foi finalizada'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * .76,
                                    40),
                              ),
                              onPressed: () {
                                clearData();
                                _returnHome(context);
                              },
                              child: const Text(
                                'Encerrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
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

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    var messages = await ref.child('messages').get();
    var messagesOfCHannel = messages.children.where((element) {
      return element.child('channelId').value.toString().contains(channelId);
    });
    messagesOfCHannel.forEach((element) {
      element.ref.remove();
    });
    var channel = ref.child('channels/$channelId');
    if (prefs.getBool("selfConsult") == true) {
      await prefs.remove("selfConsult");
      await prefs.remove("channelId");
      await channel.remove();
    } else {
      await prefs.remove("channelId");
      await channel.remove();
    }
  }

  Future<Widget> doctorAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Row(
      children: [
        CircleAvatar(child: Image.network(prefs.getString("managerAvatar")!)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: Text(
            prefs.getString("managerName")!,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DatabaseReference ref = FirebaseDatabase.instance.ref('/messages');
    final newPost = ref.push().key;
    ref.child('/$newPost').set({
      "_id": DateTime.now().microsecondsSinceEpoch,
      "belongsToPatient": true,
      "channelId": prefs.getString("channelId"),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
      "text": msg,
      "user": {
        "_id": prefs.getInt('id'),
        "name": prefs.getString('name'),
        "avatar": prefs.getString('iconAvatar')
      }
    });
    updateChannel();
  }

  updateChannel() async {
    DatabaseReference channelRef = FirebaseDatabase.instance.ref();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String channelId = prefs.getString("channelId")!;
    var messages =
        await channelRef.child("/channels/$channelId/newMessage").get();
    var value = jsonDecode(messages.value!.toString());
    int messagesValue = value as int;
    messagesValue = messagesValue + 1;
    await channelRef
        .child("/channels/$channelId/newMessage")
        .set(messagesValue.toString());
    await channelRef.child("/channels/$channelId/newMessageDoctor").set(0);
  }

  Future<bool> searchChannel(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DatabaseReference channelRef = FirebaseDatabase.instance.ref('channels');
    var channelData = await channelRef.get();
    var channel = channelData.children.where((element) =>
        element.child('userId').value == prefs.getInt('id').toString());
    if (channel.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  startChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("channelId") != null) {
      channelId = prefs.getString("channelId")!;
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('/channels/$channelId');
      var channelRef = await ref.get();
      if (channelRef.exists) {
        return channelId;
      }
    }
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
