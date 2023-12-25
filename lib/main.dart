import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //устанавливаем хайв
  await Hive.initFlutter();

  //открываем бокс

  await Hive.openBox('mybox');
  runApp(const MainApp());
}

// await Hive.openBox<TodoModel>('todos');

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
