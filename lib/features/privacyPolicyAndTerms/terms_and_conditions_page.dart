import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
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
            style: const TextStyle(fontSize: 14.0, wordSpacing: 3.5),
          ),
          const SizedBox(height: 20),
          if (widget.shouldShowAccept)
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.orange),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SelectSurveyFrequencyPage()));
              },
              child: Text(
                S.of(context).accept,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
