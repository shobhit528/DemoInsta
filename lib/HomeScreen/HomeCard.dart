import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsttech/ProfileImage.dart';

class HomeCard extends StatelessWidget {
  Color color = Colors.black;
  void Function()? onTap;

  HomeCard({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: Get.height / 2.5,
              width: Get.width,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      // image: ExactAssetImage("assets/images/main_image.png"),
                      image:
                          NetworkImage("https://picsum.photos/200/300/?blur=2"),
                      fit: BoxFit.fill),
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            "https://picsum.photos/50/50",
                            showAddIcon: false,
                            border: false,
                          ),
                          Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Dianna Russell",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      "St. Utica",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.fullscreen,
                                color: color,
                              )),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(Icons.abc, color: Colors.green),
                                Text(
                                  "+91 9876543210",
                                  style: TextStyle(
                                    color: color,
                                  ),
                                )
                              ]),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Row(children: [
                                      Expanded(
                                          child: Icon(
                                        Icons.favorite_border,
                                        color: color,
                                      )),
                                      Expanded(
                                          child: Text(
                                        "51",
                                        style: TextStyle(
                                          color: color,
                                        ),
                                      ))
                                    ])),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Icon(
                                          Icons.messenger_outline_outlined,
                                          color: color,
                                        )),
                                        Expanded(
                                            child: Text(
                                          "50",
                                          style: TextStyle(
                                            color: color,
                                          ),
                                        ))
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Icon(
                                          Icons.send,
                                          color: color,
                                        )),
                                        Expanded(
                                            child: Text(
                                          "100",
                                          style: TextStyle(
                                            color: color,
                                          ),
                                        ))
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Row(children: [
                                      Expanded(
                                          child: Icon(
                                        Icons.bookmark_border,
                                        color: color,
                                      )),
                                      Expanded(
                                          child: Text("100",
                                              style: TextStyle(color: color)))
                                    ])),
                              ]),
                          const SizedBox(
                            height: 5,
                          ),
                        ]),
                  ]),
            ),
          ),
          Container(
            height: 50,
            color: Colors.white10,
          )
        ]);
  }
}
