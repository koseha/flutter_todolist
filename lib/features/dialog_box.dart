import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a New Task'),
      content: TextField(controller: controller),
      actions: [
        TextButton(onPressed: () => onCancel(), child: Text('Cancel')),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onSubmit();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
