import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:hive_myprojcet/extensions/space_exe.dart';
import 'package:hive_myprojcet/main.dart';
import 'package:hive_myprojcet/models/NotesModels.dart';
import 'package:hive_myprojcet/pages/Widget/fab.dart';
import 'package:hive_myprojcet/pages/components/HomeAppBar.dart';
import 'package:hive_myprojcet/pages/components/sliderDrawer.dart';
import 'package:hive_myprojcet/utiles/App_String.dart';
import 'package:hive_myprojcet/utiles/app_colors.dart';
import 'package:hive_myprojcet/utiles/contants.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
// check value of circuler indicator
  dynamic valueOfIndicator(List<NotesModels> notesModels) {
    if (notesModels.isNotEmpty) {
      return notesModels.length;
    } else {
      return 3;
    }
  }
// check done Task

  int checkDoneTask(List<NotesModels> notesModels) {
    int i = 0;

    for (NotesModels doneTask in notesModels) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listentoNotesModels(),
        builder: (ctx, Box<NotesModels> box, Widget? child) {
          var notesModels = box.values.toList();
          notesModels
              .sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
          return Scaffold(
            backgroundColor: Colors.white,
            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 500,
              // Drawer
              slider: Customdrawer(),

              // appbar
              appBar: Homeappbar(drawerKey: drawerKey),
              // Main body
              child: _buildHomeBody(textTheme, base, notesModels),
            ),
            floatingActionButton: const fab(),
          );
        });
  }

  // Home body
  Widget _buildHomeBody(
    TextTheme textTheme,
    BaseWidget base,
    List<NotesModels> notesModels,
  ) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress indicator
                SizedBox(
                  height: 25,
                  width: 30,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(notesModels) /
                        valueOfIndicator(notesModels),
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.primryColor),
                  ),
                ),
                25.w,

                // To level task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStr.mainTitle, style: textTheme.displayLarge),
                    3.h,
                    Text(
                      "${checkDoneTask(notesModels)} of ${notesModels.length} task",
                      style: textTheme.titleMedium,
                    )
                  ],
                )
              ],
            ),
          ),
          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 80,
            ),
          ),

          // Adding task
          Expanded(
            child: notesModels.isNotEmpty
                ? ListView.builder(
                    itemCount: notesModels.length,
                    itemBuilder: (context, index) {
                      var notesmodels = notesModels[index];
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            base.dataStore.deleteTask(notesmodele: notesmodels);
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.grey,
                              ),
                              8.w,
                              const Text(
                                AppStr.deletedTask,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          key: Key(notesmodels.id),
                          child: taskWidget(notesModels: notesmodels));
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(LottiesUrl,
                              animate: notesModels.isNotEmpty ? false : true),
                        ),
                      ),
                      FadeInUp(
                        from: 30,
                        child: const Text(AppStr.doneAllTask),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  taskWidget({required NotesModels notesModels}) {}
}
