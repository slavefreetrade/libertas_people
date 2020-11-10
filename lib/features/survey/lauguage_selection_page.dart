import 'package:flutter/material.dart';
import 'package:libertaspeople/features/survey/survey_information_page.dart';
import 'package:libertaspeople/generated/l10n.dart';

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
      appBar: AppBar(title: Text(S.of(context).selectLanguage)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).languageSelectionPageCurrentlyEnglishIsTheOnlyLanguageAvailable, textAlign: TextAlign.center,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.of(context).back),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.of(context).next),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SurveyInformationPage(widget.surveyId)));
                  },
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
