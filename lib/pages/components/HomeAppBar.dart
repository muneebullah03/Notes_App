import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_myprojcet/main.dart';
import 'package:hive_myprojcet/utiles/contants.dart';

class Homeappbar extends StatefulWidget {
  const Homeappbar({super.key, required this.drawerKey});

  @override
  State<Homeappbar> createState() => _HomeappbarState();
  final GlobalKey<SliderDrawerState> drawerKey;
}

class _HomeappbarState extends State<Homeappbar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isDrawerOpen = false;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        widget.drawerKey.currentState!.openSlider();
        animationController.forward();
      } else {
        widget.drawerKey.currentState!.closeSlider();
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () {
                  onDrawerToggle();
                },
                icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: animationController),
                iconSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  base.isEmpty
                      ? noTaskWaring(context)
                      : deleteAllTaskWaring(context);
                },
                icon: const Icon(
                  CupertinoIcons.trash_circle,
                ),
                iconSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
