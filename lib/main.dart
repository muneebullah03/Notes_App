import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_myprojcet/data/Hive_data_Store.dart';
import 'package:hive_myprojcet/models/NotesModels.dart';
import 'package:hive_myprojcet/pages/homeScreen.dart';

void main() async {
  //intiarize the Hive db berfor app run
  await Hive.initFlutter();
  // reqister Adapter
  Hive.registerAdapter<NotesModels>(NotesModelsAdapter());

  // ignore: unused_local_variable
  var box = await Hive.openBox<NotesModels>(HiveDataStore.boxName);

  runApp(BaseWidget(child: const MyApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;
  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('could not fint acestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter TO DO APP',
      theme: ThemeData(
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                color: Colors.black, fontSize: 45, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
            displaySmall: TextStyle(
                color: Color.fromARGB(
                  255,
                  234,
                  234,
                  234,
                ),
                fontSize: 14),
            headlineMedium: TextStyle(color: Colors.grey, fontSize: 16),
            titleSmall: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            titleLarge: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w300)),
      ),
      home: const Scaffold(
        body: HomeView(),
      ),
    );
  }
}
