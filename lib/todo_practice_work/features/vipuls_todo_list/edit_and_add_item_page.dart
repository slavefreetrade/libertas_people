import 'package:flutter/material.dart';
import 'package:libertaspeople/todo_practice_work/data/todo_repository.dart';
import '../../models/todo_item_model.dart';

class EditAndAddItemPage extends StatefulWidget {
  final TodoRepository repo;
  final Function reloadParent;
  final TodoItem item;

  const EditAndAddItemPage(
      {@required this.repo, @required this.reloadParent, this.item});

  @override
  _EditAndAddItemPageState createState() => _EditAndAddItemPageState();
}

class _EditAndAddItemPageState extends State<EditAndAddItemPage> {
  TextEditingController _todoController;

  bool get iseditingItem => widget.item != null;

  @override
  void initState() {
    super.initState();
    _todoController = TextEditingController(
        text: widget.item != null ? widget.item.description : "");
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('GOT IT'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black54,
            title: iseditingItem ? Text("Edit todo") : Text("Create todo")),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: iseditingItem ? "Edit Todo" : "Create Todo",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                keyboardType: TextInputType.text,
                controller: _todoController,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    iseditingItem ? "Edit" : "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black54,
                  onPressed: () async {
                    if (iseditingItem) {
                      try {
                        await widget.repo.updateTodoItem(TodoItem(
                            uid: widget.item.uid,
                            description: _todoController.text));

                        widget.reloadParent();
                        Navigator.of(context).pop();
                      } catch (e) {
                        const errorMessage =
                            "Updating failed,Please try again!";
                        _showErrorDialog(errorMessage);
                      }
                    } else {
                      try {
                        await widget.repo.addTodoItem(
                            TodoItem(description: _todoController.text));
                        widget.reloadParent();
                        Navigator.of(context).pop();
                      } catch (e) {
                        const errorMessage = "Adding failed,Please try again!";
                        _showErrorDialog(errorMessage);
                      }
                    }
                  })
            ],
          ),
        ));
  }
}
