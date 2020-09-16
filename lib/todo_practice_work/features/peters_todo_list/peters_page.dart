import 'package:flutter/material.dart';

import 'package:libertaspeople/todo_practice_work/data/todo_repository.dart';
import 'package:libertaspeople/todo_practice_work/features/peters_todo_list/todo_list.dart';
import 'package:libertaspeople/todo_practice_work/global_widgets/our_drawer.dart';

import 'package:libertaspeople/todo_practice_work/models/custom_exceptions.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';

import 'edit_and_add_item_page.dart';
import 'network_error_card.dart';

class PetersPage extends StatefulWidget {
  final TodoRepository repo;

  const PetersPage({@required this.repo});

  @override
  _PetersPageState createState() => _PetersPageState();
}

class _PetersPageState extends State<PetersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("Peter's Page"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditAndAddItemPage(
              repository: widget.repo,
              reloadParent: () {
                setState(() {});
              },
            ),
          ));
        },
      ),
      body: Center(
        child: FutureBuilder(
          future: widget.repo.fetchTodoItems(),
          builder: (context, AsyncSnapshot<List<TodoItem>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.error is NetworkException) {
                return NetworkErrorCard(
                  errorMessage: "There was a network error, please notify user",
                  reloadParent: () {
                    setState(() {});
                  },
                );
              }
              return Card(
                child: Text("there was an unexpected error"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            List<TodoItem> todoItems = snapshot.data;

            return TodoList(
              items: todoItems,
              repo: widget.repo,
              reloadParent: () {
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
