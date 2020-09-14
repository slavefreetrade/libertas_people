import 'package:flutter/material.dart';
import 'package:libertaspeople/features/michaels_todo_list/todo_list_model.dart';
import 'package:provider/provider.dart';

class EditAndAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text(Provider.of<TodoListModel>(context).selectedTodoUid ?? 'nothing'),
    );
  }
}
