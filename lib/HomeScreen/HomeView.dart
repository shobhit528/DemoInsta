import 'package:chatapp/ChatScreen/ChatListView.dart';
import 'package:chatapp/HomeScreen/HomeController.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ProfileImage.dart';
import '../UI_Utils.dart';
import 'HomeCard.dart';

class HomeView extends StatelessWidget {
  final homecontroller = HomeController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50.mobileFont(),
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.mobileFont()),
              color: Colors.grey.shade300),
          child: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 14.mobileFont()),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Mobile Number",
              prefixIcon: Icon(
                Icons.search,
                size: 18.mobileFont(),
              ),
              contentPadding: EdgeInsets.only(left: 10.mobileFont()),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => ChatListView()),
            child: Padding(
              padding: EdgeInsets.only(right: 10.mobileFont()),
              child: Icon(
                Icons.textsms_outlined,
                color: Colors.black,
                size: 30.mobileFont(),
              ),
            ),
          )
        ],
        leadingWidth: 60.mobileFont(),
        leading: CustomImageView(
          "https://picsum.photos/40/40".random(),
          border: false,
          onTap: () => homecontroller.list.insert(
              0,
              User("Shobhit",
                  imageUrl: "".randomImage(
                      40.mobileFont().toInt(), 40.mobileFont().toInt()),
                  networkImage: true,
                  color: Colors.blueAccent.shade100)),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(
                height: 100.mobileFont(),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.mobileFont()),
                  child: Obx(() => ListView(
                      scrollDirection: Axis.horizontal,
                      children: homecontroller.list
                          .map<Widget>((element) => Padding(
                                padding:
                                    EdgeInsets.only(right: 15.mobileFont()),
                                child: CustomImageView(element.imageUrl,
                                    onTap: () =>
                                        homecontroller.onClickStatus(element),
                                    name: element.name,
                                    showAddIcon: false,
                                    networkImage: element.networkImage,
                                    color: element.color),
                              ))
                          .toList())),
                )),
            const Divider(color: Colors.grey),
            Expanded(
                child: ListView(
                    padding: EdgeInsets.only(bottom: 30.mobileFont()),
                    children: homecontroller.feedList.value
                        .map<Widget>(
                          (e) => Stack(
                            children: [
                              HomeCard(
                                feedCard: e,
                                controller: homecontroller,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: homecontroller.feedList.value
                                          .indexOf(e) ==
                                      homecontroller.currentClick.value,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: UiUtils().customImageWidget(
                                        childWidget: SizedBox(
                                          height:
                                              (Get.height / 3.0).mobileFont(),
                                          width: Get.width,
                                        ),
                                        assetImage: const AssetImage(
                                            'assets/images/heart.png')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList())),
          ],
        ),
      ),
    );
  }
}
