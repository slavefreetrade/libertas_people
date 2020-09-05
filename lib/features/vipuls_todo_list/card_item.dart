import 'package:flutter/material.dart';
import 'package:libertaspeople/features/vipuls_todo_list/edit_and_add_item_page.dart';

import '../../data/todo_repository.dart';
import '../../models/todo_item_model.dart';

class CardItem extends StatefulWidget {
  final TodoRepository repo;
  final TodoItem item;
  final Function reloadParent;

  CardItem(
      {@required this.item, @required this.repo, @required this.reloadParent});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Colors.amber,
        elevation: 6.0,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditAndAddItemPage(
                      repo: widget.repo,
                      reloadParent: widget.reloadParent,
                      item: widget.item,
                    )));
          },
          title: Text(widget.item.description),
          subtitle: Text(widget.item.uid),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                try {
                  await widget.repo.deleteTodoItem(widget.item.uid);
                  setState(() {
                    widget.reloadParent();
                  });
                } catch (e) {}
              }),
        ),
      ),
    );
  }
}
