import 'package:libertaspeople/data/local_todo_data_source.dart';
import 'package:libertaspeople/models/todo_item_model.dart';

class TodoRepository {
  final LocalTodoDataSource dataSource = LocalTodoDataSource();

  Future<List<TodoItem>> fetchTodoItems() async {
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
  }

  /// This returns the UID of the newly created item
  Future<String> addTodoItem(TodoItem item) async {
   final String generatedUid = await dataSource.addItemToDataList(item.toMap());
   return generatedUid;
  }

  Future<void> updateTodoItem(TodoItem updatedItem) async {
    await dataSource.updateDataList(updatedItem.toMap());
  }

  Future<void> deleteTodoItem(String uid)async  {
    await dataSource.deleteItem(uid);
  }
}
