import 'dart:io';

import 'package:libertaspeople/todo_practice_work/models/custom_exceptions.dart';
import 'package:libertaspeople/todo_practice_work/models/failure.dart';
import 'package:libertaspeople/todo_practice_work/models/todo_item_model.dart';

import 'local_todo_data_source.dart';

class TodoRepository {
  final LocalTodoDataSource dataSource = LocalTodoDataSource();

  Future<List<TodoItem>> fetchTodoItems() async {
    try {
      List<dynamic> dataList = await dataSource.fetchDataList();
      List<TodoItem> todoList = dataList
          .map(
            (item) => TodoItem(
              uid: item['uid'],
              description: item['description'],
            ),
          )
          .toList();
      return todoList;
    } on NetworkException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the todo list");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      throw Failure("Unhandled error");
    }
  }

  /// This returns the UID of the newly created item
  Future<String> addTodoItem(TodoItem item) async {
    final String generatedUid =
        await dataSource.addItemToDataList(item.toMap());
    return generatedUid;
  }

  Future<void> updateTodoItem(TodoItem updatedItem) async {
    await dataSource.updateDataList(updatedItem.toMap());
  }

  Future<void> deleteTodoItem(String uid) async {
    await dataSource.deleteItem(uid);
  }
}
