import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_myprojcet/models/NotesModels.dart';
import 'package:hive_myprojcet/pages/TaskView.dart';
import 'package:hive_myprojcet/utiles/app_colors.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.notesModels,
  });

  final NotesModels notesModels;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerforTitle = TextEditingController();
  TextEditingController textEditingControllerforDescription =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerforTitle.text = widget.notesModels.title;
    textEditingControllerforDescription.text = widget.notesModels.title;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerforTitle.dispose();
    textEditingControllerforDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (ctx) => TaskView(
                    titleTaskController: textEditingControllerforTitle,
                    descriptionTaskController:
                        textEditingControllerforDescription,
                    notesModels: widget.notesModels)));
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            color: widget.notesModels.isCompleted
                ? AppColors.primryColor.withOpacity(0.3)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.notesModels.isCompleted = !widget.notesModels.isCompleted;
              widget.notesModels.save();
            },

            // main card
            child: AnimatedContainer(
              width: 40,
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                  color: widget.notesModels.isCompleted
                      ? AppColors.primryColor
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .8)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          // title of the Task
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              textEditingControllerforTitle.text,
              style: TextStyle(
                  color: widget.notesModels.isCompleted
                      ? AppColors.primryColor
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: widget.notesModels.isCompleted
                      ? TextDecoration.lineThrough
                      : null),
            ),
          ),

          // subtitle of task
          // description
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              textEditingControllerforDescription.text,
              style: TextStyle(
                  color: widget.notesModels.isCompleted
                      ? AppColors.primryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: widget.notesModels.isCompleted
                      ? TextDecoration.lineThrough
                      : null),
            ),

            // Date and time

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('hh:mm a')
                          .format(widget.notesModels.createdAtDate),
                      style: TextStyle(
                          color: widget.notesModels.isCompleted
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 14),
                    ),
                    Text(
                      DateFormat.yMMMEd()
                          .format(widget.notesModels.createdAtDate),
                      style: TextStyle(
                          color: widget.notesModels.isCompleted
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
