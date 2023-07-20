import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:chatapp/UI_Utils.dart';
import 'package:chatapp/UtilsController.dart';

import '../ProfileImage.dart';
import 'ChatScreen.dart';
import 'ChatView.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text("My Conversations"),
              leading: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.keyboard_backspace_outlined)),
              expandedHeight: Get.height / 3,
              flexibleSpace: SizedBox.expand(
                child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Hero(
                          tag: const Key("heroTag"),
                          child: UiUtils().circularBorderImage(radius: 80)),
                      const Text("Test User",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      const Text("5 Unread message",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ]),
              ),
              floating: true,
              pinned: false,
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => gridTile(index),
                childCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridTile(int index) => Card(
        // generate blues with random shades
        color: Colors.black12,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.to(() => ChatScreen()),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: Text("test user $index",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))),
                  Flexible(flex: 3, child: UiUtils().circularBorderImage()),
                  const Flexible(
                      child: Text("Message title",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18))),
                  const Flexible(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content Message body content ",
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ]),
          ),
        ),
      );
}
