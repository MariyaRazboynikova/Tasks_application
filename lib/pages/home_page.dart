import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasks/data/database.dart';

import '../widgets/delete_confirmation_dialog.dart';
import '../widgets/dialog_box.dart';
import '../widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //образец бокса для того, чтобы ссылаться на него
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // если приложение открывется в первый раз, то идет загрузка дефолтных данных
    if (_myBox.get('Лист задач') == null) {
      db.createInitialData();
    } else {
      //метод, если данные уже существуют
      db.loadData();
    }
    super.initState();
  }

  //текст контроллер
  final _controller = TextEditingController();

  //нажатие чекбокса
  void checkBoxCanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //сохранение задачи
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    String textToSendBack = _controller.text;
    if (textToSendBack != null) {
      Navigator.pop(context, textToSendBack);
    }
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //добавление новой задчи
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(), //закрывает окно
        );
      },
    );
  }

// // функция удаления задачи
//   void deleteTask(int index) {
//     setState(() {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return DeleteConfirmationDialog(
//             onCancel: () {
//               Navigator.of(context).pop();
//             },
//             deleteFunction: () {
//               db.toDoList.removeAt(index);
//             },
//           );
//         },
//       );
//       db.updateDatabase();
//     });
//     db.updateDatabase();
//   }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 171, 244, 254),
        appBar: AppBar(
          title: const Center(child: Text('Дела')),
          elevation: 0, //тень
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: Icon(Icons.add)),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              //создавали ранее в туду тайл
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxCanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
