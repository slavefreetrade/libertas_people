import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/data/todo_repository.dart';
import 'package:libertaspeople/models/failure.dart';
import 'package:libertaspeople/models/todo_item_model.dart';

class TodoListModel extends ChangeNotifier {
  TodoListModel({@required this.repository});

  final TodoRepository repository;

  Either<Failure, List<TodoItem>> _todos;
  Either<Failure, List<TodoItem>> get todos => _todos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _selectedTodoUid;
  String get selectedTodoUid => _selectedTodoUid;

  void _setIsLoadingTo(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  void _setTodos(Either<Failure, List<TodoItem>> todos) {
    _todos = todos;
  }

  void updateSelectedTodoUid(String uid) {
    assert(uid != null);

    _selectedTodoUid = uid;
    notifyListeners();
  }

  Future<void> loadTodos() async {
    _setIsLoadingTo(true);

    await Task(() => repository.fetchTodoItems())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((todoList) => _setTodos(todoList));

    _setIsLoadingTo(false);
  }

  Future<void> removeTodo(TodoItem todo) async {
    assert(todo != null);
    assert(todo.uid != null);

    _setIsLoadingTo(true);
    await repository.deleteTodoItem(todo.uid);
    _setIsLoadingTo(false);
  }

  Future<void> addTodo(TodoItem todo) async {
    assert(todo != null);

    _setIsLoadingTo(true);
    await repository.addTodoItem(todo);
    _setIsLoadingTo(false);
  }

  Future<void> updateTodo(TodoItem todo) async {
    assert(todo != null);
    assert(todo.uid != null);

    _setIsLoadingTo(true);
    await repository.updateTodoItem(todo);
    _setIsLoadingTo(false);
  }
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return this.map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
