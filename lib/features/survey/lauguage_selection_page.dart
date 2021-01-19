import 'package:flutter/material.dart';
import 'package:libertaspeople/features/survey/survey_information_page.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/buttons/button_bordered_with_back_arrow.dart';
import 'package:libertaspeople/shared_ui_elements/buttons/button_full_color_with_next_arrow.dart';

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
            padding: const EdgeInsets.fromLTRB(48, 16, 48, 16),
            child: Row(
              children: [
                Expanded(
                  child: ButtonBorderedWithBackArrow(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    previousButtonLabel: "Back",
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ButtonFullColorWithNextArrow(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SurveyInformationPage(widget.surveyId),
                        ),
                      );
                    },
                    isFinalQuestion: false,
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
