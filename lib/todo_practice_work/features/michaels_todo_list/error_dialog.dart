import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:libertaspeople/todo_practice_work/data/todo_repository.dart';
import 'package:libertaspeople/todo_practice_work/features/michaels_todo_list/michaels_page.dart';


class ErrorDialog extends StatefulWidget {
  final String errorDetails;

  const ErrorDialog({@required this.errorDetails});

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  String get errorDetails => widget.errorDetails;

  MaterialPageRoute<dynamic> get refreshRoute => MaterialPageRoute(
        builder: (context) => MichaelsPage(repo: TodoRepository()),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorDetails),
          _buildRefreshButton(context),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _showDialog(context));
  }

  _buildRefreshButton(BuildContext context) {
    return FlatButton(
      child: Text('Refresh'),
      onPressed: () {
        Navigator.of(context)
            .pushAndRemoveUntil(refreshRoute, (Route<dynamic> route) => false);
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('An error has occurred'),
          content: new Text(errorDetails),
          actions: <Widget>[
            _buildRefreshButton(context),
            FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
