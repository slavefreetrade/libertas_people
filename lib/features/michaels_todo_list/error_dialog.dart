import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:libertaspeople/data/todo_repository.dart';
import 'package:libertaspeople/ui/pages/michaels_page.dart';

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

  _refreshPage(BuildContext context) {
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
            _refreshPage(context),
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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _showDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorDetails),
        _refreshPage(context),
      ],
    );
  }
}
