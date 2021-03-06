import 'package:flutter/material.dart';
import 'package:libertaspeople/features/privacyPolicyAndTerms/terms_and_conditions_page.dart';

import '../../generated/l10n.dart';
import '../../shared_ui_elements/colors.dart';

class PrivacyPolicyPage extends StatefulWidget {
  final bool shouldShowAccept;

  const PrivacyPolicyPage({Key key, this.shouldShowAccept = false})
      : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: Text(
          S.of(context).privacyPolicy,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16.0, left: 25, right: 25),
        children: [
          Text(
            S.of(context).privacyPolicyContent,
            style: const TextStyle(fontSize: 14.0, wordSpacing: 3.5),
          ),
          const SizedBox(height: 20),
          if (widget.shouldShowAccept)
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppColors.orange,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TermsAndConditionsPage(
                          shouldShowAccept: true,
                        )));
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
