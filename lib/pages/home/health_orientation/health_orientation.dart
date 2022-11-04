import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      ),
    );
  }
}
