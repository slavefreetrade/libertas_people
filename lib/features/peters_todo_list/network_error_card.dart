import 'package:flutter/material.dart';

class NetworkErrorCard extends StatefulWidget {
  final String errorMessage;
  final Function reloadParent;

  const NetworkErrorCard({
    @required this.errorMessage,
    @required this.reloadParent,
  });

  @override
  _NetworkErrorCardState createState() => _NetworkErrorCardState();
}

class _NetworkErrorCardState extends State<NetworkErrorCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.errorMessage,
              style: TextStyle(fontSize: 18),
            ),
            isLoading
                ? CircularProgressIndicator()
                : RaisedButton(
                    child: Text("refetch data"),
                    onPressed: () {
                      widget.reloadParent();
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
