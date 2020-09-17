import 'package:flutter/material.dart';
import 'file:///E:/projects/libertas_people/lib/todo_practice_work/features/michaels_todo_list/todo_list_model.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';

import 'package:provider/provider.dart';

class EditAndAddWidget extends StatefulWidget {
  @override
  _EditAndAddWidgetState createState() => _EditAndAddWidgetState();
}

class _EditAndAddWidgetState extends State<EditAndAddWidget> {
  TextEditingController controller;
  bool isTodoValid = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TodoListModel>(context);
    controller.text = provider.selectedTodo?.description ?? '';
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                    labelText:
                        provider.isEditing ? "Edit a Todo" : "Add a Todo",
                    border: InputBorder.none,
            ),
                controller: controller,
              ),
            ),
            provider.isEditing
                ? Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => _editTodo(),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTodo(),
                      ),
                    ],
                  )
                : IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _addTodo(),
                  ),
          ],
        ),
      ),
    );
  }

  void _addTodo() {
    final todoText = controller.text;
    if(todoText.isEmpty) return;
    final todo = TodoItem(description: todoText);
    Provider.of<TodoListModel>(context, listen: false).addTodo(todo);
    _resetInputField();
  }

  void _editTodo() {
    final todoText = controller.text;
    if(todoText.isEmpty) return;
    final selectedUid = Provider.of<TodoListModel>(context, listen: false).selectedTodo.uid;
    final todo = TodoItem(description: todoText, uid: selectedUid);
    Provider.of<TodoListModel>(context, listen: false).editTodo(todo);
    _resetInputField();
  }

  void _deleteTodo() {
    Provider.of<TodoListModel>(context, listen: false).deleteTodo();
    _resetInputField();
  }

  void _resetInputField() {
    controller.clear();
    FocusScope.of(context).unfocus();
  }
}
