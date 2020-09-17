import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///E:/projects/libertas_people/lib/todo_practice_work/features/michaels_todo_list/todo_list_model.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/error_dialog.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/todo_empty_list.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/todo_list_item.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListModel>(
      builder: (_, notifier, __) {
        if (notifier.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return notifier.todos.fold(
            (failure) => ErrorDialog(errorDetails: failure.toString()),
            (todoList) => todoList.isEmpty
                ? TodoEmptyList()
                : ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return TodoListItem(item: todoList[index]);
                    },
                  ),
          );
        }
      },
    );
  }
}
