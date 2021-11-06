import 'package:flutter/material.dart';

class InitialBackgroundView extends StatelessWidget {
  const InitialBackgroundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          right: -130,
          child: Image.asset(
            'assets/mydashatar.png',
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          right: -100,
          child: Image.asset(
            'assets/mydashatar.png',
            height: 200,
          ),
        )
      ],
    );
  }
}
