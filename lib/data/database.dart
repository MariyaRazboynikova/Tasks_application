import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  //образец нашего бокса
  final _myBox = Hive.box('mybox');

  //метод запускается, когда приложение открыто в первый раз
  void createInitialData() {
    toDoList = [
      ["Make tutorial", false],
      ["Do exercise", false],
    ];
  }

  //загрузка данных из базы данных
  void loadData() {
    toDoList = _myBox.get('Лист задач');
  }

  //обновление базы данных
  void updateDatabase() {
    _myBox.put('Лист задач', toDoList);
  }
}
