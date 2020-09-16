import 'package:flutter/material.dart';
import 'package:libertaspeople/todo_practice_work/data/todo_repository.dart';
import 'package:libertaspeople/todo_practice_work/models/custom_exceptions.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';


class EditAndAddItemPage extends StatefulWidget {
  final TodoItem item;
  final TodoRepository repository;
  final Function reloadParent;

  const EditAndAddItemPage({
    this.item,
    @required this.repository,
    @required this.reloadParent,
  });

  @override
  _EditAndAddItemPageState createState() => _EditAndAddItemPageState();
}

class _EditAndAddItemPageState extends State<EditAndAddItemPage> {
  // I am using getters to clean up my code so I
  // don't have to type widget.field everywhere
  TodoRepository get repo => widget.repository;

  TodoItem get item => widget.item;

  // If I don't pass a [TodoItem] into this page,
  // that means I am creating a new one
  // Using Enums may make my code cleaner,
  // especially if this page gets more complex
  bool get isEditingItem => item != null;
  bool isLoading = false;

  TextEditingController controller;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.item != null ? item.description : "");
  }

  Future<void> handleApiCall(Function apiCall) async {
    setState(() {
      isLoading = true;
    });
    try {
      await apiCall();

      widget.reloadParent();
      Navigator.of(context).pop();
    } catch (e) {
      if (e is NetworkException) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("There was a network error, please try again")));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                "There was an unexpected error, please check my code. This error should be handled in development")));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(isEditingItem ? item.description : "add new item"),
        actions: <Widget>[
          if (isEditingItem)
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      handleApiCall(() async {
                        await repo.deleteTodoItem(item.uid);
                      });
                    },
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText:
                    isEditingItem ? "edit description" : "create description",
              ),
            ),
            RaisedButton(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(isEditingItem ? "edit" : "add"),
              onPressed: isLoading
                  ? null
                  : () async {
                      handleApiCall(() async {
                        if (isEditingItem) {
                          await repo
                              .updateTodoItem(TodoItem(
                                  uid: item.uid, description: controller.text))
                              .then((value) => null);
                        } else {
                          final String uid = await repo.addTodoItem(
                              TodoItem(description: controller.text));
                        }
                      });
                    },
            )
          ],
        ),
      ),
    );
  }
}
