import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ligdoctor_pro/components/home_page_navigation_item.dart';
import 'package:ligdoctor_pro/services/auth_service.dart';
import 'package:ligdoctor_pro/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/banners_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final Size displaySize = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return FutureBuilder(
        future: auth(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Image.asset(
                    'assets/images/Logo-escura.png',
                  ),
                  centerTitle: true,
                  toolbarHeight: 70,
                  leadingWidth: 80,
                  backgroundColor: Colors.white,
                  leading: FutureBuilder<Widget>(
                    future: userAvatar(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      Flexible(
                        flex: 30,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .05),
                          child: CarouselSlider(
                            items: [
                              Image.asset(
                                'assets/images/banner1.png',
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/banner2.png',
                                fit: BoxFit.cover,
                              ),
                            ],
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                      Flexible(
                        flex: 30,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: displaySize.height * .02,
                          spacing: displaySize.width * .025,
                          children: [
                            const HomePageNavigationItem(
                              category: 'Teleconsultas',
                              src: 'assets/images/phone.png',
                            ),
                            const HomePageNavigationItem(
                              category: 'Orientação em saúde',
                              src: 'assets/images/chat.png',
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: Container(
                                width: displaySize.width * .27,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: displaySize.height * .1,
                                      width: displaySize.width * .2,
                                      padding: const EdgeInsets.all(8),
                                      child: FittedBox(
                                        child: FaIcon(
                                          FontAwesomeIcons.usersViewfinder,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: displaySize.width * .25,
                                      height: displaySize.height * .05,
                                      child: Text(
                                        'Pacientes',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          height: 1,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const HomePageNavigationItem(
                              category: 'Financeiro',
                              src: 'assets/images/salary.png',
                            ),
                            const HomePageNavigationItem(
                              category: 'Financeiro',
                              src: 'assets/images/customer-support.png',
                            ),
                            const HomePageNavigationItem(
                              category: 'Minha conta',
                              src: 'assets/images/gear.png',
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ));
          } else {
            return const SplashScreen();
          }
        });
  }

  auth() async {
    await Autentication().callCheck();
    return true;
  }

  Future<Widget> userAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CircleAvatar(
        backgroundImage: NetworkImage(prefs.getString("iconAvatar")!),
      ),
    );
  }
}