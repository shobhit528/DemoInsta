import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  bool border, showAddIcon, networkImage;
  String? url, name;
  Color? color;
  void Function()? onTap;

  CustomImageView(this.url,
      {this.border = true,
      this.showAddIcon = true,
      this.name,
      this.networkImage = true,
      this.color,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: color ?? Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: border
                          ? Border.all(width: 2, color: Colors.red)
                          : null),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.hardEdge,
                    child: networkImage
                        ? SizedBox(
                            height: 40.mobileFont(),
                            width: 40.mobileFont(),
                            child: CachedNetworkImage(
                              imageUrl: url!,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : Image.asset(
                            url!,
                            height: 40.mobileFont(),
                            width: 40.mobileFont(),
                          ),
                  ),
                ),
                showAddIcon
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.add_box_rounded,
                          size: 15.mobileFont(),
                          color: Colors.amber,
                        ))
                    : const SizedBox()
              ],
            ),
            name != null
                ? Flexible(
                    child: Text(
                    name!,
                    style: TextStyle(fontSize: 12.mobileFont()),
                  ))
                : const SizedBox(),
          ])),
    );
  }
}
