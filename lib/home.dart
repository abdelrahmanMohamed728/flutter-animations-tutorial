import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const defaultWidth = 200.0;

class _HomePageState extends State<HomePage> {
  var _width = defaultWidth;
  var _isZoomedIn = false;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 370,
                  ),
                  width: _width,
                  curve: _curve,
                  child: Image.network(
                      'https://source.unsplash.com/user/c_v_r/1900x800'),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isZoomedIn = !_isZoomedIn;
                _width = _isZoomedIn ? 350.0 : 200.0;
                _curve = _isZoomedIn ? Curves.easeIn : Curves.easeOut;
              });
            },
            child: const Text(
              "Change Zoom Level",
            ),
          ),
        ],
      ),
    );
  }
}
