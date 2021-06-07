import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width<1200? 0.0: size.width*.8,
      height: size.height,
      child: Center(child: Text("DeshBoard")),

    );
  }
}
