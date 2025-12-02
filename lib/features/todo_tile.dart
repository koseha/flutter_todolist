import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String todo;
  final bool isCompleted;
  final Function(bool?)? onTap;

  const TodoTile({
    super.key,
    required this.todo,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: onTap,
              activeColor: Colors.black,
              checkColor: Colors.white,
            ),
            Text(
              todo,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                decoration: isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.white,
                decorationThickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
