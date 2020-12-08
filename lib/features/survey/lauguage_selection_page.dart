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
                child: Text(
                  S
                      .of(context)
                      .languageSelectionPageCurrentlyEnglishIsTheOnlyLanguageAvailable,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  padding: EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                      Text(
                        S.of(context).back,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(
                      7,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Text(
                        S.of(context).next,
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 30,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SurveyInformationPage(widget.surveyId),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
