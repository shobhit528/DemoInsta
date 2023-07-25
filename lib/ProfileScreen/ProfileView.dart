import 'package:chatapp/ProfileScreen/ProfileController.dart';
import 'package:chatapp/ProfileScreen/profile_bloc/profile_bloc.dart';
import 'package:chatapp/UI_Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../UtilsController.dart';

class ProfileView extends StatelessWidget {
  final ProfileBloc profileBloc;

  ProfileView(this.profileBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            margin: const EdgeInsets.only(right: 5, top: 10),
            padding: const EdgeInsets.all(10),
            color: Colors.blueAccent.shade100,
            child: const Text("Logout"),
          ),
          onTap: () => profileBloc.add(LogoutClickEvent())),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  profielBanner(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => profileBloc.add(FollowClickEvent()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              width: Get.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppThemeColor),
                              child: const Text(
                                "Follow",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => profileBloc.add(MessageClickEvent()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              width: Get.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: AppThemeColor, width: 1)),
                              child: Text(
                                "Message",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppThemeColor),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                      height: 70.mobileFont(),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 40.mobileFont(),
                                width: 60.mobileFont(),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () => profileBloc
                                          .add(AddHighlightsClickEvent()),
                                      child: Container(
                                        width: 50.mobileFont(),
                                        height: 50.mobileFont(),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: const Color.fromRGBO(
                                                    249, 179, 109, 1),
                                                width: 1)),
                                        child:  Icon(
                                          Icons.add,
                                          size: 20.mobileFont(),
                                          color: Color.fromRGBO(249, 179, 109, 1),
                                        ),
                                      ),
                                    )),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              for (var element in (profileBloc.state
                                      as ProfileLoadSuccessState)
                                  .heighLightlist)
                                GestureDetector(
                                  onTap: () =>
                                      profileBloc.add(HighlightsClickEvent(element.url)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: customHightlightView(element.url,
                                        element.name, element.color),
                                  ),
                                )
                            ]),
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () => profileBloc.add(PhotosClickEvent()),
                            child: Icon(
                              Icons.image_outlined,
                              color: AppThemeColor,
                              size: 30,
                            ),
                          )),
                          Flexible(
                              child: Container(
                            height: 30,
                            width: 5,
                            color: Colors.grey.shade400,
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () => profileBloc.add(VideosClickEvent()),
                            child: const Icon(
                              Icons.menu_book,
                              size: 30,
                            ),
                          )),
                        ]),
                  ),
                  StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 6,
                    children: (profileBloc.state as ProfileLoadSuccessState)
                        .list
                        .map<Widget>((Item item) => itemRender(item))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profielBanner({String? str}) => Container(
    constraints: BoxConstraints(
        minHeight: Get.height / 2.7, maxHeight: UiUtils().isWeb()  ? Get.height / 1.5 : Get.height / 2.2 ),
    width: Get.width,
    padding: const EdgeInsets.all(10),
    child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Column(children: [
            Expanded(
                flex: UiUtils().isMobile() ? 4 :UiUtils().isTab()? 6: 8,
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),child: Image.network("".randomImageWithOutDimention(widthScale: 2),
                    width: Get.width, fit: BoxFit.fill),)),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(right: 30),
                          child: Column(children: const [
                            Flexible(
                              child: Text("32k",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                            ),
                            Flexible(
                              child: Text("Followers",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey)),
                            )
                          ]),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(children: const [
                            Flexible(
                              child: Text("320",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                            ),
                            Flexible(
                              child: Text("Following",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey)),
                            )
                          ]),
                        )),
                  ]),
                )),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(children: const [
                    Flexible(
                        child: Text("Jenny Wilson",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24))),
                    Flexible(
                        child: Text("Sr. Product Manager",
                            style:
                            TextStyle(fontSize: 22, color: Colors.grey))),
                  ]),
                )),
          ]),
          Positioned(
            bottom: 100,
            child: profileViewImage(),
          )
        ]),
  );

  Widget profileViewImage() => Container(
    alignment: Alignment.center,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: const BoxDecoration(
      shape: BoxShape.circle),
    child:
    // Image.network("https://xsgames.co/randomusers/avatar.php?g=female", fit: BoxFit.contain),
      ClipRRect(
        borderRadius: BorderRadius.circular(60.0.mobileFont()),
        child: Image.network(
          "https://xsgames.co/randomusers/avatar.php?g=female",
          fit: BoxFit.cover,
        ),
      )
  );

  Widget itemRender(Item item) => StaggeredGridTile.count(
    crossAxisCellCount: item.crossAxisCellCount!,
    mainAxisCellCount: item.mainAxisCellCount!,
    child: Container(
      width: Get.width / 3.1,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: item.color!,
        image: item.networkImage
            ? DecorationImage(image: NetworkImage(item.url!), fit: BoxFit.fill)
            : DecorationImage(
            image: ExactAssetImage(item.url!), fit: BoxFit.fill),
      ),
    ),
  );

  Widget customHightlightView(String? url, name, Color? color) =>
      SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      url!,
                      height: 50.mobileFont(),
                      width: 50.mobileFont(),
                    ),
                  ),
                ),
                name != null
                    ? Flexible(
                    child: Text(
                      name!,
                      style: TextStyle(fontSize: 12.mobileFont()),
                    ))
                    : SizedBox(),
              ]));

}
