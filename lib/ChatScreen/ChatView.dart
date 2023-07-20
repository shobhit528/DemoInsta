import 'package:chatapp/ChatScreen/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Get_IT.dart';
import '../UI_Utils.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                //title: const Text("My Conversations"),
                leading: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.keyboard_backspace_outlined)),
                expandedHeight: Get.height / 3.5,
                flexibleSpace: SizedBox.expand(
                  child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceAround,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Hero(
                            tag: const Key("heroTag"),
                            child: UiUtils().circularBorderImage(radius: 90)),
                        const Text("Test User",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ]),
                ),
                floating: false,
                pinned: true,
              ),
              Obx(() => SliverList(
                    delegate: SliverChildListDelegate.fixed(
                        getIt<ChatController>()
                            .dataList
                            .map<Widget>((e) =>
                                senderReceiverView(e, isSender: e % 2 == 0))
                            .toList()),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget senderReceiverView(int index, {bool isSender = true}) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: isSender
              ? const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))
              : const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        child: Card(
          color: isSender ? Colors.green : Colors.blueGrey,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Text("$index line message"),
          ),
        ),
      ),
    );
  }
}
