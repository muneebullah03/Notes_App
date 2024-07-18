import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_myprojcet/extensions/space_exe.dart';
import 'package:hive_myprojcet/pages/homeScreen.dart';
import 'package:hive_myprojcet/utiles/app_colors.dart';

class Customdrawer extends StatelessWidget {
  Customdrawer({super.key});

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  final List<String> texts = ["Home", "Profile", "Settings", "Detials"];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors.primryGradientColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            child: Icon(Icons.person_3_rounded),
          ),
          8.h,
          Text(
            'Muneeb Ullah',
            style: textTheme.displayMedium,
          ),
          5.h,
          Text(
            'Flutter Developer',
            style: textTheme.displaySmall,
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeView()));
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          leading:
                              Icon(icons[index], color: Colors.white, size: 30),
                          title: Text(
                            texts[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
