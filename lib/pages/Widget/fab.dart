// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_myprojcet/pages/TaskView.dart';
import 'package:hive_myprojcet/utiles/app_colors.dart';

class fab extends StatelessWidget {
  const fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => TaskView(
                      titleTaskController: TextEditingController(),
                      descriptionTaskController: TextEditingController(),
                      notesModels: null,
                    )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.primryColor,
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
