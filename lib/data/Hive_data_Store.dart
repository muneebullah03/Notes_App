import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_myprojcet/models/NotesModels.dart';

// all crud operation Havi
class HiveDataStore {
  // box name
  static const boxName = 'taskBox';

  // current box with all saved data inside

  final Box<NotesModels> box = Hive.box(boxName);

  // add new task to Box

  Future<void> addTask({required NotesModels notesModels}) async {
    await box.put(notesModels.id, notesModels);
  }

  // show all Task data
  Future<NotesModels?> getTask({required String id}) async {
    return box.get(id);
  }
  //update task

  Future<void> updateTask({required NotesModels notesmodele}) async {
    await notesmodele.save();
  }
  // delete Task

  Future<void> deleteTask({required NotesModels notesmodele}) async {
    await notesmodele.delete();
  }

  // listen to box Changes

  ValueListenable<Box<NotesModels>> listentoNotesModels() => box.listenable();
}
