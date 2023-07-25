import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';

class UiUtils {
  Widget circularBorderImage(
          {String? url, double? radius = 45, double borderWidth = 2}) =>
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: borderWidth),
              shape: BoxShape.circle),
          child: CircleAvatar(
            maxRadius: UiUtils().isTab() ? radius! * 2 : radius,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                url ?? "https://picsum.photos/1024/1024".random(),
                fit: BoxFit.fill,
              ),
            ),
          ));

  bool isTab() => deviceMode() == Screen.tablet;

  bool isMobile() => deviceMode() == Screen.mobile;

  bool isWeb() => deviceMode() == Screen.web;

  static Screen deviceMode() {
    final width = MediaQuery.of(Get.context!).size.width;
    if (width <= 599) {
      return Screen.mobile;
    } else if (width <= 1050 && width >= 600) {
      return Screen.tablet;
    } else {
      return Screen.web;
    }
  }

  Widget customImageWidget(
      {required Widget childWidget,
      required AssetImage assetImage}) {
    SpriteSheet sparkleSpriteSheet = SpriteSheet(image: assetImage);

    final ParticleField starField = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      // use the sprite alpha, with the particle color:
      // top left will be 0,0:
      origin: Alignment.topLeft,
      // blendMode: BlendMode.dstIn,
      // onTick is where all the magic happens:
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        // add a new particle each frame:
        particles.add(Particle(
          color: Colors.black,
          // set a random x position along the width:
          x: rnd(size.width - 10),
          // set a random size:
          scale: rnd(0.05, 0.2),
          // show a random frame:
          frame: rnd(sparkleSpriteSheet.length * 1).floor(),
          // set a y velocity:
          vy: rnd(1, 8),
        ));
        // update existing particles:

        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          // call update, which automatically adds vx/vy to x/y
          particle.update();
          // remove particle if it's out of bounds:
          if (!size.contains(particle.toOffset())) particles.removeAt(i);
        }
      },
    );

    return starField.stackAbove(
      child: childWidget,
      scale: 1.1,
    );
  }

  Widget rainWidget({required Widget childWidget}) {
    final SpriteSheet sparkleSpriteSheet =
        SpriteSheet(image: const AssetImage('assets/images/drop.png'));

    final ParticleField starField = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      // use the sprite alpha, with the particle color:
      // top left will be 0,0:
      origin: Alignment.topLeft,
      // blendMode: BlendMode.dstIn,
      // onTick is where all the magic happens:
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        // add a new particle each frame:
        particles.add(Particle(
          color: Colors.black,
          // set a random x position along the width:
          x: rnd(size.width - 10),
          // set a random size:
          scale: rnd(0.005, 0.02),
          // show a random frame:
          frame: rnd(sparkleSpriteSheet.length * 1.0).floor(),
          // set a y velocity:
          vy: rnd(2, 15),
        ));
        // update existing particles:
        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          // call update, which automatically adds vx/vy to x/y
          particle.update();
          // remove particle if it's out of bounds:
          if (!size.contains(particle.toOffset())) particles.removeAt(i);
        }
      },
    );

    return starField.stackAbove(
      child: childWidget,
      scale: 1.1,
    );
  }

  Widget birdWidget({required Widget childWidget}) {
    final SpriteSheet sparkleSpriteSheet = SpriteSheet(
      image: const AssetImage('assets/images/bird_bg.gif'),
    );

    final ParticleField starField = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      anchor: Alignment.center,
      // use the sprite alpha, with the particle color:
      // top left will be 0,0:
      origin: Alignment.topLeft,
      // blendMode: BlendMode.dstIn,
      // onTick is where all the magic happens:
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        // add a new particle each frame:
        particles.add(Particle(
            color: Colors.white,
            // set a random x position along the width:
            x: rnd(size.width - 10),
            // set a random size:
            scale: rnd(0.3, 0.1),
            // show a random frame:
            frame: rnd(sparkleSpriteSheet.length * 1).floor(),
            // set a y velocity:
            vy: rnd(6, 2),
            rotation: -150,
            y: 10,
            vx: 1.0));
        // update existing particles:

        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          particle.update();
          if (!size.contains(particle.toOffset())) particles.removeAt(i);
        }
      },
    );

    return starField.stackAbove(
      child: childWidget,
      scale: 1.1,
    );
  }
}

enum Screen { tablet, web, mobile }
