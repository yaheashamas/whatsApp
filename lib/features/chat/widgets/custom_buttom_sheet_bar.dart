import 'package:flutter/material.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/features/chat/widgets/custom_item_buttom_sheet_menu.dart';

class CustomButtomSheetBar extends StatelessWidget {
  final AnimationController controller;
  final Animation animationHight;
  final Animation animationWidth;
  CustomButtomSheetBar({
    super.key,
    required this.controller,
  })  : animationHight = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.5, curve: Curves.easeInOut),
          ),
        ),
        animationWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.5, curve: Curves.easeInOut),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: GridView(
        clipBehavior: Clip.hardEdge,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 120,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          CustomItemButtonSheetMenu(
            backGround: openDocumentColor,
            icon: Icons.insert_drive_file_rounded,
            title: "Document",
            onTap: () {},
          ),
          CustomItemButtonSheetMenu(
            backGround: openCameraColor,
            icon: Icons.camera_alt,
            title: "Camera",
            onTap: () {},
          ),
          CustomItemButtonSheetMenu(
            backGround: openGallaryColor,
            icon: Icons.image,
            title: "Gallary",
            onTap: () {},
          ),
          CustomItemButtonSheetMenu(
            backGround: openAudioColor,
            icon: Icons.headphones,
            title: "Audio",
            onTap: () {},
          ),
        ],
      ),
      builder: (BuildContext context, Widget? child) {
        return Container(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.topCenter,
          height: animationHight.value * 250,
          width: animationWidth.value * MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(20).copyWith(bottom: 0),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: const Offset(1, 1),
                spreadRadius: 0.5,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
          child: controller.value <= 0.5 ? Container() : child,
        );
      },
    );
  }
}
