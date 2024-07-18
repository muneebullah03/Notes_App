// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:hive_myprojcet/main.dart';
import 'package:hive_myprojcet/utiles/App_String.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

// ignore: non_constant_identifier_names
String LottiesUrl = 'asesst/lotties/1.json';

// empty title or subtitle
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMessage,
      subMsg: 'You must fill all field!',
      corner: 20.0,
      duration: 1000,
      padding: const EdgeInsets.all(20));
}

// edit or update
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMessage,
      subMsg: 'You must edit the task then try to Update it!',
      corner: 20.0,
      duration: 5000,
      padding: const EdgeInsets.all(20));
}

dynamic noTaskWaring(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      title: AppStr.oopsMessage,
      message:
          'There is no task for Delete! \n Try add some and then try to Delete it!',
      buttonText: 'Okay', onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

dynamic deleteAllTaskWaring(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      title: AppStr.areYouSure,
      message:
          'Do you really delete All Task? you will be not able to undo this Action',
      confirmButtonText: 'Yes',
      cancelButtonText: 'No', onTapConfirm: () {
    BaseWidget.of(context).dataStore.box.clear();
    Navigator.pop(context);
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error, barrierDismissible: true);
}
