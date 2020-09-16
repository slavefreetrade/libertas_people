import 'package:flutter/material.dart';
import 'package:libertaspeople/todo_practice_work/data/todo_repository.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/error_dialog.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/todo_empty_list.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/todo_list.dart';
import 'package:libertaspeople/todo_practice_work/global_widgets/our_drawer.dart';
import 'package:libertaspeople/todo_practice_work/models/custom_exceptions.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';


class MichaelsPage extends StatelessWidget {
  final TodoRepository repo;

  const MichaelsPage({@required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("Michael's Page"),
      ),
      body: Center(
        child: FutureBuilder(
          future: repo.fetchTodoItems(),
          builder: (context, AsyncSnapshot<List<TodoItem>> snapshot) {
            if (snapshot.hasError)
              return _handleSnapshotError(snapshot);
            else if (snapshot.isLoading)
              return CircularProgressIndicator();
            else if (snapshot.isEmpty)
              return TodoEmptyList();
            else
              return TodoListStatelessWidget(items: snapshot.data);
          },
        ),
      ),
    );
  }

   _handleSnapshotError(AsyncSnapshot<List<TodoItem>> snapshot) {
    if (snapshot.error is NetworkException)
      return ErrorDialog(errorDetails: 'There was network error, please try again');
    else
      return ErrorDialog(errorDetails: 'There was an unexpected error, please try again');
  }
}

//Todo: refactor to a separate utils file
extension on AsyncSnapshot {
  bool get isLoading => this.connectionState == ConnectionState.waiting;
  bool get isEmpty => this.data.length == 0;
}
