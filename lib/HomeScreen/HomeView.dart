import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tsttech/HomeScreen/HomeController.dart';

import '../ProfileImage.dart';
import 'HomeCard.dart';

class HomeView extends StatelessWidget {
  final homecontroller = HomeController();

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Mobile Number",
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.only(left: 10, top: 15),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.textsms_outlined,
              color: Colors.black,
            ),
          )
        ],
        leading: CustomImageView("https://picsum.photos/40/40", border: false),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Obx(() => ListView(
                      scrollDirection: Axis.horizontal,
                      children: homecontroller.list
                          .map<Widget>((element) => Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: CustomImageView(element.imageUrl,
                                    onTap: ()=>homecontroller.onClickStatus(element),
                                    name: element.name,
                                    showAddIcon: false,
                                    networkImage: false,
                                    color: element.color),
                              ))
                          .toList())),
                )),
            Divider(color: Colors.grey),
            Expanded(
                child: ListView(
                    children:
                        [1, 2, 3].map<Widget>((e) => HomeCard()).toList()))
          ],
        ),
      ),
    );
  }
}
