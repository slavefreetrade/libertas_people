import 'package:flutter/material.dart';
import 'package:libertaspeople/data/todo_repository.dart';
import 'package:libertaspeople/global_widgets/our_drawer.dart';
import 'package:provider/provider.dart';

import 'todo_list_view.dart';
import 'todo_list_model.dart';

class MichaelsPage extends StatelessWidget {
  final TodoRepository repo;

  const MichaelsPage({@required this.repo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoListModel(repository: repo)..loadTodos(),
      child: Scaffold(
        drawer: OurDrawer(),
        appBar: AppBar(
          title: Text("Michael's Page"),
        ),
        body: TodoListView(),
      ),
    );
  }
}
