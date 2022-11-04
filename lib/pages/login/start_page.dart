import 'package:flutter/material.dart';
import '../../../components/curved_border.dart';
import '../../../components/login_button.dart';
import '../../../utils/routes.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  _login(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  _register(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.register);
  }

  @override
  Widget build(BuildContext context) {
    final Size displaySize = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: displaySize.width,
            height: displaySize.height * .6,
            child: Image.asset(
              'assets/images/woman-using-smartphone.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: displaySize.height * .35),
            width: displaySize.width,
            child: Stack(
              children: [
                const CurvedBorder(Colors.white),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: Image.asset(
                        'assets/images/default-bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: displaySize.height * 0.15),
                  height: displaySize.height * .5,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: displaySize.width,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/Logo-escura.png',
                              scale: 0.75,
                            ),
                            SizedBox(
                              height: displaySize.height * 0.02,
                            ),
                            Text(
                              'Saúde na palma da mão',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: displaySize.height * 0.02,
                            ),
                            InkWell(
                              onTap: () => _login(context),
                              child: LoginButton(
                                Theme.of(context).colorScheme.primary,
                                'ENTRAR NA MINHA CONTA',
                              ),
                            ),
                            SizedBox(
                              height: displaySize.height * 0.01,
                            ),
                            InkWell(
                              onTap: () => _register(context),
                              child: LoginButton(
                                Theme.of(context).colorScheme.tertiary,
                                'CRIAR CONTA',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
