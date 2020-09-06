import 'package:flutter/widgets.dart';
import 'package:libertaspeople/features/michaels_todo_list/todo_list_item.dart';
import 'package:libertaspeople/models/todo_item_model.dart';

class TodoListStatelessWidget extends StatelessWidget {
  final List<TodoItem> items;

  const TodoListStatelessWidget({@required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return TodoListItemWidget(item: items[index]);
        });
  }
}
