import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  bool border, showAddIcon, networkImage;
  String? url, name;
  Color? color;

  CustomImageView(this.url,
      {this.border = true,
      this.showAddIcon = true,
      this.name,
      this.networkImage = true,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: color?? Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: border
                        ? Border.all(width: 2, color: Colors.red)
                        : null),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.hardEdge,
                  child: networkImage
                      ? Image(
                          image: NetworkImage(url!),
                        )
                      : Image.asset(
                          url!,
                          height: 50,
                          width: 50,
                        ),
                ),
              ),
              showAddIcon
                  ? Positioned(
                      child: Icon(
                        Icons.add_box_rounded,
                        size: 20,
                        color: Colors.amber,
                      ),
                      bottom: 0,
                      right: 0)
                  : SizedBox()
            ],
          ),
          name != null ? Flexible(child: Text(name!)) : SizedBox(),
        ]));
  }
}
