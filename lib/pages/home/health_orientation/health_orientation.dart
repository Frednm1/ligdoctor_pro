import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ligdoctor_pro/pages/home/health_orientation/chat.dart';
import 'package:ligdoctor_pro/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthOrientation extends StatefulWidget {
  const HealthOrientation({super.key});

  @override
  State<HealthOrientation> createState() => _HealthOrientationState();
}

class _HealthOrientationState extends State<HealthOrientation> {
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
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1),
            child: Column(
              children: [
                const Text(
                  'Atedimento via Chat',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                    height: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .1),
                  child: const Text(
                    'Abaixo segue uma lista de chats para seu atendimento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      height: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseDatabase.instance.ref('').onValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return FutureBuilder<Widget>(
                            future: loadChannels(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget> loadChannels() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('channels');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var channels = await ref.get();
    var myChannels = channels.children.where(
        (element) => element.child('doctorId').value == prefs.getInt('id'));
    int length = myChannels.length;
    if (length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Ops...',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Parece que nenhum chat foi aberto até agora',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        height: length * 90,
        child: ListView.builder(
          itemCount: length,
          itemBuilder: (context, i) {
            DateTime time = DateTime.fromMicrosecondsSinceEpoch(int.parse(
                myChannels.elementAt(i).child('createdAt').value.toString()));

            return InkWell(
              onTap: () => _chat(
                  context,
                  myChannels.elementAt(i).child('_id').value.toString(),
                  myChannels.elementAt(i).child('userId').value.toString()),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                height: 80,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          myChannels
                              .elementAt(i)
                              .child('userName')
                              .value
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            '${time.day}/${time.month}/${time.year} às ${time.hour}:${time.minute}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          myChannels
                              .elementAt(i)
                              .child('newMessage')
                              .value
                              .toString(),
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_sharp,
                      color: Colors.black12,
                      size: 30,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  _chat(BuildContext context, String channelId, String patientId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Chat(
        channelId: channelId,
        patientId: patientId,
      );
    }));
  }
}
