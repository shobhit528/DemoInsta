import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../UiUtils/custom_painter.dart';

class ShaderHomePage extends StatefulWidget {
  @override
  State<ShaderHomePage> createState() => _ShaderHomePageStateState();
}

class _ShaderHomePageStateState extends State<ShaderHomePage> {
  late Timer timer;

  double delta = 0;

  FragmentShader? shader;

  void loadMyShader() async {
    var program = await FragmentProgram.fromAsset('shaders/shader.frag');
    shader = program.fragmentShader();
    setState(() {
      // trigger a repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 6), (timer) {
      setState(() {
        delta += 1 / 60;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyShader();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(painter: ShaderPainter(shader!, delta)),
            ),
            Center(child: Opacity(
                opacity: 0.5,
                alwaysIncludeSemantics: true,
                child: Container(
                  margin: const EdgeInsets.only(top: 15,left: 10),
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(painter: ShaderPainter(shader!, delta)),
                )),)
          ]);
    }
  }
}
