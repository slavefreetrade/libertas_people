import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:libertaspeople/models/custom_exceptions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class LocalTodoDataSource {
  final Uuid idGenerator = Uuid();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _todoFile async {
    final path = await _localPath;

    return File('$path/todo_list.txt');
  }

  /// If the simulated network call takes too long ( is >650 milliseconds)
  /// an exception will be thrown. Please show user a message saying there
  /// was a timeout
  Future<void> simulateNetworkCallWaitingPeriod() async {
    Random random = new Random();
    int randomNumber = random.nextInt(2500) + 50;
    await Future.delayed(Duration(milliseconds: randomNumber));
    if (randomNumber > 2300) {
      throw NetworkException();
    }
  }

  Future<List<dynamic>> fetchDataList() async {
    await simulateNetworkCallWaitingPeriod();

    File todoFile = await _todoFile;

    // Here I am creating some starting data for the todo list
    if (!(await todoFile.exists())) {
      List<Map<String, dynamic>> startingTodoListData = [
        {
          "uid": idGenerator.v1(),
          "description": "go get eggs and a party hat",
        },
        {
          "uid": idGenerator.v1(),
          "description": "cook dinner",
        },
        {
          "uid": idGenerator.v1(),
          "description": "figure out why peters code is acting goofy"
        }
      ];

      todoFile.writeAsStringSync(json.encode(startingTodoListData));
    }
    String fileContents = todoFile.readAsStringSync();
    List<dynamic> dataList = json.decode(fileContents);
    return dataList;
  }

  Future<void> updateDataList(Map<String, dynamic> updatedItem) async {
    await simulateNetworkCallWaitingPeriod();

    File todoFile = await _todoFile;

    List<dynamic> dataList = await fetchDataList();

    List<dynamic> updatedList = dataList.map((element) {
      if (element['uid'] == updatedItem['uid']) {
        return updatedItem;
      }
      return element;
    }).toList();

    final String jsonString = json.encode(updatedList);

    todoFile.writeAsStringSync(jsonString, mode: FileMode.writeOnly);
  }

  Future<String> addItemToDataList(Map<String, dynamic> newItem) async {
    newItem['uid'] = idGenerator.v1();
    await simulateNetworkCallWaitingPeriod();
    File todoFile = await _todoFile;
    List<dynamic> dataList = await fetchDataList();
    dataList.add(newItem);
    final String jsonString = json.encode(dataList);
    todoFile.writeAsStringSync(jsonString, mode: FileMode.writeOnly);
    return newItem['uid'];
  }

  Future<void> deleteItem(String uid) async {
    File todoFile = await _todoFile;

    List<dynamic> dataList = await fetchDataList();
    dataList.removeWhere((element) {
      return element['uid'] == uid;
    });

    final String jsonString = json.encode(dataList);
    todoFile.writeAsStringSync(jsonString, mode: FileMode.writeOnly);
  }
}
