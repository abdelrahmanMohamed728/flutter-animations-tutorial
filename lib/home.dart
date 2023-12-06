import 'package:animation_tutorial/circle_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Color getRandomColor() => Color(
      0xFF000000 +
          math.Random().nextInt(
            0x00FFFFFF,
          ),
    );

class _HomePageState extends State<HomePage> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: CircleClipeer(),
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1, milliseconds: 200),
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color,
            ),
            onEnd: (){
              setState(() {
                _color = getRandomColor();
              });
            },
            builder: (BuildContext context, Color? value, Widget? child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  value!,
                  BlendMode.srcATop,
                ),
                child: child,
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
