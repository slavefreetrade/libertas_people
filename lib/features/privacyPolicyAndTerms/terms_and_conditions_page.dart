import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../shared_ui_elements/buttons/button_orange_color.dart';
import '../../shared_ui_elements/colors.dart';
import '../select_survey_frequency_page.dart';

class TermsAndConditionsPage extends StatefulWidget {
  final bool shouldShowAccept;

  const TermsAndConditionsPage({Key key, this.shouldShowAccept = false})
      : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: Text(
          S.of(context).termsAndConditions,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16.0, left: 25, right: 25),
        children: [
          Text(
            S.of(context).termsAndConditionsContent,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          if (widget.shouldShowAccept)
            ButtonOrangeColor(
                label: S.of(context).accept,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SelectSurveyFrequencyPage()));
                }),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
