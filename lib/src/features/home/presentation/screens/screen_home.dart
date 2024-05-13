import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';

class ScreenHome extends StatelessWidget{
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: Center(
          child: Text("Welcome to Home"),
        ),
      ),
    );
  }

}