import 'package:flutter/material.dart';

class CurvedBorder extends StatelessWidget {
  final Color bgColor;
  const CurvedBorder(this.bgColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: CustomClipPath(),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double x = size.width;
    double y = size.height;

    final path = Path();
    path.lineTo(0, y - 100);
    path.quadraticBezierTo(
      x * 0.5,
      y,
      x,
      y - 100,
    );
    path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
