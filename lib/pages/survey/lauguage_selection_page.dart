import 'package:flutter/material.dart';
import 'package:libertaspeople/pages/survey/survey_information_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  final String surveyId;

  const LanguageSelectionPage(this.surveyId);

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Language")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("english is the only language available"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text("Okay, continue to instructions"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SurveyInformationPage(widget.surveyId)));
                },
              ),
            ],
          )
        ],
      )),
    );
  }
}
