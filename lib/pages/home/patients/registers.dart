// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Registers extends StatefulWidget {
  var data;
  Registers({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  State<Registers> createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
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
        child: Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.data['business']['customer']
                                    ['avatar'] ==
                                null
                            ? 'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg'
                            : widget.data['business']['customer']['avatar']
                                    ['file'] ??
                                'https://d1bvpoagx8hqbg.cloudfront.net/259/eb0a9acaa2c314784949cc8772ca01b3.jpg'),
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
                        widget.data['business']['customer']['name'],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(widget.data['business']['customer']['email']),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'Registro de atendimentos',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Text('teste');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
