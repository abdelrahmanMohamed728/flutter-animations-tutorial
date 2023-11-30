import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'colors.dart';

class ThreeDContainer extends StatefulWidget {
  const ThreeDContainer({super.key});

  @override
  State<ThreeDContainer> createState() => _ThreeDContainerState();
}

class _ThreeDContainerState extends State<ThreeDContainer>
    with TickerProviderStateMixin {
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
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                  width: double.infinity,
                ),
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _xController,
                    _yController,
                    _zController,
                  ]),
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateX(_animation.evaluate(_xController))
                        ..rotateY(_animation.evaluate(_yController))
                        ..rotateZ(_animation.evaluate(_zController)),
                      child: Stack(
                        children: [
                          // back
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..translate(Vector3(0, 0, -100)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: navyBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: 100,
                              height: 100,
                            ),
                          ),
                          // left side
                          Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()..rotateY(pi / 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: navyBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: 100,
                              height: 100,
                            ),
                          ),
                          // left side
                          Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()..rotateY(-pi / 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: navyBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: 100,
                              height: 100,
                            ),
                          ),
                          // front
                          Container(
                            decoration: BoxDecoration(
                              color: navyBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: 100,
                            height: 100,
                          ),
                          // top side
                          Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()..rotateX(-pi / 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: navyBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: 100,
                              height: 100,
                            ),
                          ),
                          // bottom side
                          Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()..rotateX(pi / 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: navyBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
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
