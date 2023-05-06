import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tsttech/Get_IT.dart';
import 'package:tsttech/HomeScreen/HomeController.dart';
import 'package:tsttech/Login/LoginScreen.dart';
import 'package:tsttech/ProfileImage.dart';
import 'package:tsttech/ProfileScreen/ProfileController.dart';
import 'package:tsttech/UtilsController.dart';
import 'package:tsttech/main.dart';

class ProfileView extends StatelessWidget {
  final profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.only(right: 5, top: 10),
          padding: EdgeInsets.all(10),
          color: Colors.blueAccent.shade100,
          child: Text("Logout"),
        ),
        onTap: () {
          getIt<UtilsController>().setLoggedin(false);
          Get.offAll(() => LoginScreen());
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfielBanner(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromRGBO(249, 179, 109, 1)),
                            child: Text(
                              "Follow",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: Color.fromRGBO(249, 179, 109, 1),
                                    width: 1)),
                            child: Text(
                              "Message",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(249, 179, 109, 1)),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                      height: 70,
                      width: Get.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Obx(() => ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                            child: Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      249, 179, 109, 1),
                                                  width: 1)),
                                          child: Icon(Icons.add,
                                              color: Color.fromRGBO(
                                                  249, 179, 109, 1)),
                                        )),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  for (var element
                                      in profileController.HeighLightlist)
                                    Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: CustomHightlightView(element.url,
                                          element.name, element.color),
                                    )
                                ])),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(children: [
                      Expanded(
                          flex: 40,
                          child: Icon(
                            Icons.image_outlined,
                            color: Color.fromRGBO(249, 179, 109, 1),
                            size: 30,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey.shade400,
                          )),
                      Expanded(
                          flex: 40,
                          child: Icon(
                            Icons.menu_book,
                            size: 30,
                          )),
                    ]),
                  ),
                  // Wrap(
                  //     crossAxisAlignment: WrapCrossAlignment.start,
                  //     alignment: WrapAlignment.start,
                  //     clipBehavior: Clip.antiAlias,
                  //     children: [150, 200, 100, 200, 100, 200, 150, 300]
                  //         .map<Widget>(
                  //             (e) => ItemRender(heightValue: e.toDouble()))
                  //         .toList()),
                  Obx(() => StaggeredGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 6,
                        children: profileController.CardlistItem.map<Widget>(
                            (Item item) => ItemRender(item)).toList(),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ProfielBanner({String? str}) => Container(
      height: Get.height / 2.7,
      width: Get.width,
      padding: EdgeInsets.all(10),
      child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Column(children: [
              Image.asset("assets/images/cover_image.png",
                  width: Get.width, fit: BoxFit.fill),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Column(children: [
                      Text("32k",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      Text("Followers",
                          style: TextStyle(fontSize: 20, color: Colors.grey))
                    ]),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(children: [
                      Text("320",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      Text("Following",
                          style: TextStyle(fontSize: 20, color: Colors.grey))
                    ]),
                  )),
                ]),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Column(children: [
                  Expanded(
                      child: Text("Jenny Wilson",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24))),
                  Expanded(
                      child: Text("Sr. Product Manager",
                          style: TextStyle(fontSize: 22, color: Colors.grey))),
                ]),
              )),
            ]),
            ProfileViewImage()
          ]),
    );

Widget ProfileViewImage() => Container(
      height: 80,
      width: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.teal.shade500, borderRadius: BorderRadius.circular(10)),
      child:
          Image.asset("assets/images/image_profile.png", fit: BoxFit.contain),
    );

Widget ItemRender(Item item) => StaggeredGridTile.count(
      crossAxisCellCount: item.crossAxisCellCount!,
      mainAxisCellCount: item.mainAxisCellCount!,
      child: Container(
        width: Get.width / 3.1,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: item.color!,
            image: DecorationImage(
                image: ExactAssetImage(item.url!), fit: BoxFit.fill)),
      ),
    );
