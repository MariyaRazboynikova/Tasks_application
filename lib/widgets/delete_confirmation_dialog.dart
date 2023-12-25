import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final void Function() onCancel;
  final void Function() deleteFunction;

  const DeleteConfirmationDialog(
      {super.key, required this.onCancel, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Подтверждение удаления'),
      content: const Text('Вы уверены, что хотите удалить эту задачу?'),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Заркыть'),
        ),
        TextButton(
          onPressed: deleteFunction,
          child: const Text('Удалить'),
        ),
      ],
    );
  }
}
