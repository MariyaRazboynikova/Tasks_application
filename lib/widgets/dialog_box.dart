import 'package:flutter/material.dart';
import 'package:tasks/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 118, 255, 193),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Добавь новую задчу",
              ),
            ),
            //кнопка: сохранить+закрыть
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //кнопка закрытия
                MyButton(text: "Закрыть", onPressed: onCancel),

                Container(
                  child: Padding(padding: EdgeInsets.all(5)),
                ),
                //кнопка сохранения
                MyButton(text: "Сохранить", onPressed: onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
