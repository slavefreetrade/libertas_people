import 'package:flutter/material.dart';
import 'package:libertaspeople/models/todo_item_model.dart';

class TodoListItemWidget extends StatelessWidget {
  final TodoItem item;

  const TodoListItemWidget({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.description),
        subtitle: Text(item.uid),
      ),
    );
  }
}
