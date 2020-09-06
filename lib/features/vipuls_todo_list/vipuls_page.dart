import 'package:flutter/material.dart';
import 'package:libertaspeople/features/vipuls_todo_list/card_item.dart';
import 'package:libertaspeople/features/vipuls_todo_list/edit_and_add_item_page.dart';
import 'package:libertaspeople/global_widgets/our_drawer.dart';

import '../../data/todo_repository.dart';
import '../../models/todo_item_model.dart';

class VipulsPage extends StatefulWidget {
  final TodoRepository repo;

  const VipulsPage({@required this.repo});

  @override
  _VipulsPageState createState() => _VipulsPageState();
}

class _VipulsPageState extends State<VipulsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Vipul's Page"),
      ),
      drawer: OurDrawer(),
      body: FutureBuilder(
          future: widget.repo.fetchTodoItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          "There is an unexpected error!!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FlatButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Text(
                              "RETRY",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
            List<TodoItem> items = snapshot.data;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => CardItem(
                      item: items[index],
                      repo: widget.repo,
                      reloadParent: () {
                        setState(() {});
                      },
                    ));
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditAndAddItemPage(
                  repo: widget.repo,
                  reloadParent: () {
                    setState(() {});
                  })));
        },
        backgroundColor: Colors.black54,
      ),
    );
  }
}
