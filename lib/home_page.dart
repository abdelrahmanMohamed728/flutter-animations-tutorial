import 'dart:ffi';
import 'dart:math';

import 'package:animation_tutorial/animation_controller.dart';
import 'package:animation_tutorial/circle_side.dart';
import 'package:animation_tutorial/half_circle_clipper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _rotationZAnimationController;
  late Animation<double> _rotationZAnimation;

  late AnimationController _rotationYAnimationController;
  late Animation<double> _rotationYAnimation;

  @override
  void initState() {
    initRotationZAnimation();
    initRotationYAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _rotationZAnimationController.dispose();
    _rotationYAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startZRotation();
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _rotationZAnimationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_rotationZAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: _rotationYAnimationController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..rotateY(_rotationYAnimation.value),
                            child: const ClipPath(
                              clipper: HalfCircleClipper(
                                  circleSide: CircleSide.left),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: Colors.red),
                                ),
                              ),
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: _rotationYAnimationController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..rotateY(_rotationYAnimation.value),
                            child: const ClipPath(
                              clipper: HalfCircleClipper(
                                  circleSide: CircleSide.right),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: DecoratedBox(
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }

  void initRotationZAnimation() {
    _rotationZAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _rotationZAnimation = Tween<double>(begin: 0, end: pi / 2).animate(
      CurvedAnimation(
        parent: _rotationZAnimationController,
        curve: Curves.elasticInOut,
      ),
    );
    animationControllerZListener();
  }

  void animationControllerZListener() {
    _rotationZAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationYAnimation = Tween<double>(
          begin: _rotationYAnimation.value,
          end: _rotationYAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: _rotationYAnimationController,
            curve: Curves.easeInOutCirc,
          ),
        );
        startYRotation();
      }
    });
  }

  void initRotationYAnimation() {
    _rotationYAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    _rotationYAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: _rotationYAnimationController,
        curve: Curves.easeInOutCirc,
      ),
    );
    animationControllerYListener();
  }

  void animationControllerYListener() {
    _rotationYAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (status == AnimationStatus.completed) {
          _rotationZAnimation = Tween<double>(
            begin: _rotationZAnimation.value,
            end: _rotationZAnimation.value + (pi / 2),
          ).animate(
            CurvedAnimation(
              parent: _rotationZAnimationController,
              curve: Curves.elasticInOut,
            ),
          );
          startZRotation();
        }
      }
    });
  }

  void startZRotation() {
    _rotationZAnimationController
      ..reset()
      ..forward.delayed(
        const Duration(
          seconds: 1,
        ),
      );
  }

  void startYRotation() {
    _rotationYAnimationController
      ..reset()
      ..forward.delayed(
        const Duration(
          seconds: 1,
        ),
      );
  }
}
