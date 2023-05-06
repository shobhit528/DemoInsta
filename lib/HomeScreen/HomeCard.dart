import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsttech/ProfileImage.dart';

class HomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: Get.height / 2.5,
            width: Get.width,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new ExactAssetImage("assets/images/main_image.png"),
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
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                            child: Icon(
                              Icons.fullscreen,
                              color: Colors.black,
                            ),
                            flex: 1),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.whatsapp, color: Colors.green),
                              Text("+91 9876543210")
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Row(children: [
                                    Expanded(
                                        child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    )),
                                    Expanded(child: Text("51"))
                                  ]),
                                  flex: 1),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Icon(
                                        Icons.messenger_outline_outlined,
                                      )),
                                      Expanded(child: Text("50"))
                                    ],
                                  ),
                                  flex: 1),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: Icon(Icons.send)),
                                      Expanded(child: Text("100"))
                                    ],
                                  ),
                                  flex: 1),
                              Expanded(
                                  child: Row(children: [
                                    Expanded(
                                        child: Icon(
                                      Icons.bookmark_border,
                                    )),
                                    Expanded(child: Text("100"))
                                  ]),
                                  flex: 1),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                ]),
          ),
          Container(
            height: 50,
            color: Colors.white10,
          )
        ]);
  }
}
