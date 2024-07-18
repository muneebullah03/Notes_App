// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:hive_myprojcet/main.dart';
import 'package:hive_myprojcet/models/NotesModels.dart';
import 'package:hive_myprojcet/utiles/contants.dart';
import 'package:intl/intl.dart';
import 'package:hive_myprojcet/pages/components/Repo_textField.dart';
import 'package:hive_myprojcet/pages/components/TastViewAppBar.dart';
import 'package:hive_myprojcet/pages/components/date_time_PIcker.dart';
import 'package:hive_myprojcet/utiles/App_String.dart';
import 'package:hive_myprojcet/utiles/app_colors.dart';

class TaskView extends StatefulWidget {
  TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.notesModels,
  });

  final TextEditingController titleTaskController; // Change: made non-nullable
  final TextEditingController
      descriptionTaskController; // Change: made non-nullable
  final NotesModels? notesModels;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? date;
  DateTime? time;

  // show Selected Time as String
  String showTime(DateTime? time) {
    if (widget.notesModels?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.notesModels!.createdAtTime)
          .toString();
    }
  }

  // delete Task
  dynamic deleteTask() {
    return widget.notesModels!.delete();
  }

  // show Selected date as String
  String ShowDate(DateTime? time) {
    if (widget.notesModels?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.notesModels!.createdAtTime)
          .toString();
    }
  }

  // if any task already exist return True otherwise return false;
  bool isTaskAlreadyExist() {
    if (widget.titleTaskController.text.isEmpty &&
        widget.descriptionTaskController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // show selected date as a Dateformat for init time
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.notesModels?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.notesModels!.createdAtDate;
    }
  }

  // main function for creating and updating Task
  dynamic isTaskAlreadyExistUpdateOtherwiseCreate() {
    // update current Task
    if (widget.titleTaskController.text.isNotEmpty &&
        widget.descriptionTaskController.text.isNotEmpty) {
      try {
        widget.titleTaskController.text = title;
        widget.descriptionTaskController.text = subTitle;
        widget.notesModels!.save();
        Navigator.pop(context);
      } catch (e) {
        // update empty task warning
        updateTaskWarning(context);
      }
    }
    // here we create a New Task
    else {
      if (title != null && subTitle != null) {
        var notesModels = NotesModels.create(
            title: title,
            subtitle: subTitle,
            createdAtDate: date,
            createdAtTime: time);
        BaseWidget.of(context).dataStore.addTask(notesModels: notesModels);
        Navigator.pop(context);
      } else {
        emptyWarning(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        // App bar
        appBar: const Tastviewappbar(),

        // Body
        body: SingleChildScrollView(
          child: Column(
            children: [
              topSideText(textTheme),
              _BuildMiainTaskViewActivity(textTheme, context),
              _BuildButtonSideButton()
            ],
          ),
        ),
      ),
    );
  }

  // Bottom buttons
  Widget _BuildButtonSideButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          if (!isTaskAlreadyExist())
            MaterialButton(
              onPressed: () {
                deleteTask();
                Navigator.pop(context);
              },
              minWidth: 150,
              color: Colors.white,
              height: 55,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.close,
                    color: AppColors.primryColor,
                  ),
                  Text(
                    AppStr.deleteTask,
                    style: TextStyle(color: AppColors.primryColor),
                  ),
                ],
              ),
            ),
          // Add or update task button
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherwiseCreate();
            },
            minWidth: 150,
            color: AppColors.primryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            height: 55,
            child: Text(
              isTaskAlreadyExist()
                  ? AppStr.addtaskString
                  : AppStr.updatetaskString,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Main task view activity
  Widget _BuildMiainTaskViewActivity(
      TextTheme textTheme, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20), // Adjust padding here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            
            AppStr.titleofTitleTextFeild,
            style: textTheme.headlineMedium,
          ),
          RepoTextFormField(
            controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),
          const SizedBox(height: 10),
          RepoTextFormField(
            controller: widget.descriptionTaskController,
            onFieldSubmitted: (String inputDescription) {
              subTitle = inputDescription;
            },
            onChanged: (String inputDescription) {
              subTitle = inputDescription;
            },
          ),
          const SizedBox(height: 10),

          // Date and time selection
          DateandtimePicker(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 280,
                        child: TimePickerWidget(
                          initDateTime: showDateAsDateTime(time),
                          onChange: (__, _) {},
                          onConfirm: (dateTime, _) {
                            setState(() {
                              if (widget.notesModels!.createdAtTime == null) {
                                time = dateTime;
                              } else {
                                widget.notesModels!.createdAtTime = dateTime;
                              }
                            });
                          },
                        ),
                      ));
            },
            title: AppStr.timeString,
            time: showTime(time),
          ),
          // Date selection
          DateandtimePicker(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                initialDateTime: showDateAsDateTime(date),
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.notesModels!.createdAtDate == null) {
                      date = dateTime;
                    } else {
                      widget.notesModels!.createdAtDate = dateTime;
                    }
                  });
                },
              );
            },
            title: AppStr.dateString,
            time: ShowDate(date),
            isTime: true,
          ),
        ],
      ),
    );
  }

  // Top side text
  SizedBox topSideText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          Expanded(
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: isTaskAlreadyExist()
                        ? AppStr.addNewTask
                        : AppStr.updateCurrentTask,
                    style: textTheme.titleLarge,
                    children: const [
                      TextSpan(
                          text: AppStr.taskString,
                          style: TextStyle(fontWeight: FontWeight.w400))
                    ]),
              ),
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
