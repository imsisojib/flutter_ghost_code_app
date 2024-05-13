import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';

class Background extends StatelessWidget{
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          )
        ),
        child: child,
      ),
    );
  }
}