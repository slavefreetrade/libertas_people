import 'package:flutter/material.dart';
import 'package:libertaspeople/todo_practice_work/data/todo_repository.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';

import 'edit_and_add_item_page.dart';

class TodoList extends StatelessWidget {
  final TodoRepository repo;
  final List<TodoItem> items;
  final Function reloadParent;

  const TodoList(
      {@required this.items, @required this.repo, @required this.reloadParent});

  @override
  Widget build(BuildContext context) {
    return items.length == 0
        ? Center(child: Text("No items, please create one!"))
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              TodoItem item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.description),
                  subtitle: Text(item.uid ?? "no uid set"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditAndAddItemPage(
                          item: item,
                          repository: repo,
                          reloadParent: reloadParent,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
