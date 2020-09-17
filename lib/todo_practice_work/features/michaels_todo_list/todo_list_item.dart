import 'package:flutter/material.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/todo_list_model.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';
import 'package:provider/provider.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem item;

  const TodoListItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<TodoListModel>(context, listen: false)
          .setSelectedTodo(item),
      child: Card(
        child: ListTile(
          title: Text(item.description),
          subtitle: Text(item.uid),
        ),
      ),
    );
  }
}
