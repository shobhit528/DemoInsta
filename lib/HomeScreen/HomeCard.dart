import 'package:chatapp/ProfileImage.dart';
import 'package:chatapp/UI_Utils.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'HomeController.dart';

class HomeCard extends StatelessWidget {
  final Color color = Colors.black;
  final feedCardClass feedCard;

  const HomeCard({super.key, required this.feedCard});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeBloc>().onCardClick(feedCard),
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        height: (Get.height / 2.8).mobileFont(),
        width: Get.width,
        margin: EdgeInsets.all(10.mobileFont()),
        decoration: BoxDecoration(
          image: DecorationImage(
              // image: ExactAssetImage("assets/images/main_image.png"),
              image: NetworkImage(feedCard.feedImage),
              fit: BoxFit.fill),
          color: Colors.black26,
          borderRadius: BorderRadius.circular(15.mobileFont()),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                  flex: UiUtils().isMobile() ? 2 : 1,
                  child: Container(
                    color: Colors.white54,
                    padding: EdgeInsets.symmetric(horizontal: 5.mobileFont()),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            feedCard.image,
                            showAddIcon: false,
                            border: false,
                          ),
                          Expanded(
                              flex: 8,
                              child: Container(
                                // color: Colors.white54,
                                padding: EdgeInsets.only(left: 10.mobileFont()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Animate(
                                        effects: const [
                                          ScaleEffect(
                                              begin: Offset(0, 0),
                                              end: Offset(1, 1),
                                              curve: Curves.ease,
                                              duration: Duration(seconds: 3),
                                              alignment: Alignment.center)
                                          // ColorEffect(
                                          //     duration: Duration(seconds: 5),
                                          //     delay: Duration(seconds: 1),
                                          //     begin: Colors.transparent,
                                          //     end: Colors.transparent)
                                        ],
                                        child: Text(
                                          feedCard.name,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18.mobileFont(),
                                              color: Colors.black),
                                        )),
                                    Text(
                                      feedCard.title,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12.mobileFont(),
                                          color: Colors.black),
                                    ).animate().shimmer(
                                        duration: 5000.ms,
                                        colors: [
                                          Colors.black,
                                          Colors.green,
                                          Colors.blueGrey
                                        ],
                                        stops: [
                                          1,
                                          3,
                                          5.9
                                        ]).scale(duration: 5000.ms),
                                  ],
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Stack(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              color: Colors.white70,
                                              child: SizedBox(
                                                height: (Get.height / 1.8)
                                                    .mobileFont(),
                                                width: Get.width,
                                                child: InteractiveViewer(
                                                  panEnabled: false,
                                                  // Set it to false
                                                  boundaryMargin:
                                                      const EdgeInsets.all(100),
                                                  minScale: 0.5,
                                                  maxScale: 5,
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Image.network(
                                                    feedCard.feedImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: 10.mobileFont(),
                                                top: 10.mobileFont(),
                                                child: GestureDetector(
                                                  onTap: () => Get.back(),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape
                                                                .circle),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 50.mobileFont(),
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        )),
                                child: Icon(
                                  Icons.fullscreen,
                                  color: color,
                                  size: 30.mobileFont(),
                                ),
                              )),
                        ]),
                  )),
              const Expanded(flex: 5, child: SizedBox()),
              Flexible(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                              color: Colors.white38,
                              child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(Icons.abc, color: Colors.green),
                                    Text(
                                      "+91 9876543210",
                                      style: TextStyle(
                                        color: color,
                                      ),
                                    )
                                  ])),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.white38,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: BlocConsumer(
                                      listener: (context, state) {
                                        context.read<HomeBloc>().emit("");

                                        return;
                                      },
                                      bloc: HomeBloc(context: context),
                                      builder: (context, state) => iconTitleRow(
                                          context.read<HomeBloc>().isLiked(
                                                  context
                                                      .read<HomeBloc>()
                                                      .feedList
                                                      .indexOf(feedCard))
                                              ? Icons.favorite_border
                                              : Icons.favorite,
                                          feedCard.likes,
                                          () => context
                                              .read<HomeBloc>()
                                              .onButtonClick(feedCard)),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: iconTitleRow(
                                          Icons.messenger_outline_outlined,
                                          feedCard.messages,
                                          () {})),
                                  Expanded(
                                      flex: 1,
                                      child: iconTitleRow(
                                          Icons.send,
                                          feedCard.shared,
                                          () => UiUtils().showDialogSending(feedCard, context))),
                                  Expanded(
                                      flex: 1,
                                      child: iconTitleRow(Icons.bookmark_border,
                                          feedCard.saved, () {})),
                                ]),
                          ),
                        ),
                      ])),
            ]),
      ),
    );
  }

  Widget iconTitleRow(
          IconData icon, String text, void Function()? onButtonTap) =>
      GestureDetector(
        onTap: onButtonTap,
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            Expanded(
                    child: Icon(
              icon,
              size: 20.mobileFont(),
            ))
                .animate()
                .shimmer(
                    duration: 5000.ms,
                    colors: [color, Colors.blueGrey, Colors.red],
                    stops: [1, 3, 5.9])
                .fade(duration: 500.ms)
                .scale(delay: 500.ms),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: color, fontSize: 18.mobileFont()),
            )
                    .animate()
                    .shimmer(
                        duration: 5000.ms,
                        colors: [color, Colors.blueGrey, Colors.red],
                        stops: [1, 3, 5.9])
                    .fade(duration: 500.ms)
                    .scale(delay: 500.ms))
          ],
        ),
      );
}
