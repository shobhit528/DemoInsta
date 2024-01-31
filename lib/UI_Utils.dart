import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';

import 'HomeScreen/HomeController.dart';

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

  showDialogSending(feedCardClass userFeed, BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Compose a message"),
              content: SizedBox(
                width: Get.width,
                height: Get.height / 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Card(
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 3, color: Colors.grey)),
                          child: TextFormField(
                            controller: controller,
                            maxLines: 3,decoration: const InputDecoration(border: InputBorder.none),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                              quickSendRow(name: userFeed.name),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              actions: [OutlinedButton(onPressed: () {}, child: Text("Send"))],
            ));
  }

  Widget quickSendRow({String? name = ""}) => Card(
        elevation: 6,
        margin: const EdgeInsets.all(5),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          leading: Container(
              width: 100,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 40.0.mobileFont(),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0.mobileFont()),
                child: Image.network(
                  "https://xsgames.co/randomusers/avatar.php?g=female",
                  fit: BoxFit.cover,
                ),
              )),
          title: Text("$name"),
          trailing: Container(
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      color: Colors.grey.shade100,
                      blurRadius: 1)
                ],
                border: Border.all(color: Colors.blue, width: 1)),
            child: const Icon(
              Icons.send,
              color: Colors.blue,
            ),
          ),
        ),
      );

  Widget customImageWidget(
      {required Widget childWidget, required AssetImage assetImage}) {
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

extension RangeList on int{
  listRange() => List.generate(this - 0 + 1, (i) => i + 0);
}