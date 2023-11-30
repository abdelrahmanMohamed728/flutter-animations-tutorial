import 'dart:math' show pi;

import 'package:flutter/material.dart';

import 'colors.dart';

class OneDContainer extends StatefulWidget {
  const OneDContainer({Key? key}) : super(key: key);

  @override
  State<OneDContainer> createState() => _OneDContainerState();
}

class _OneDContainerState extends State<OneDContainer> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    );
    _animation = Tween<double>(begin: 0.0, end: pi * 2);
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initControllers();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFbdc3c7), Color(0xFF2c3e50)],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.repeated),
          ),
          child: Center(
            child: AnimatedBuilder(
                animation: Listenable.merge(
                    [_xController, _yController, _zController]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_xController))
                      ..rotateY(_animation.evaluate(_yController))
                      ..rotateZ(_animation.evaluate(_zController)),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: navyBlue,
                      ),
                      width: 105,
                      height: 100,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void initControllers() {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();
  }
}
