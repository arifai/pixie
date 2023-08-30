import 'package:flutter/material.dart';

class HalfRounded extends StatelessWidget {
  const HalfRounded({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: _HalfRoundedPath(), child: child);
  }
}

class _HalfRoundedPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height - 30);

    final Offset firstControlPoint = Offset(size.width / 4, size.height);
    final Offset firstPoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstPoint.dx,
      firstPoint.dy,
    );

    final Offset secondPoint = Offset(size.width, size.height - 30);
    final Offset secondControlPoint = Offset(
      size.width - (size.width / 4),
      size.height,
    );

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondPoint.dx,
      secondPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
