import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/environment_config.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';

class SelectSurveyFrequencyPage extends StatefulWidget {
  @override
  _SelectSurveyFrequencyPageState createState() =>
      _SelectSurveyFrequencyPageState();
}

class _SelectSurveyFrequencyPageState extends State<SelectSurveyFrequencyPage> {
  final Repository repo = Repository();

  Duration _frequency = const Duration(minutes: 2);

  bool _isLoading = false;

  Future<void> enterApp({int surveyFrequencyInMinutes}) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      await repo.createUser();
      await repo.fetchAndStoreQualtricsSurveys(
          surveyFrequencyInMinutes ?? _frequency.inMinutes);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TabBarController()));
    }
  }

  @override
  void initState() {
    super.initState();
    if (EnvironmentConfig.isProd) {
      enterApp(surveyFrequencyInMinutes: const Duration(days: 30).inMinutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading
          ? null
          : AppBar(
              title: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("Select Survey Frequency"),
              ),
            ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                        child: CupertinoPicker(
                      magnification: 1.5,
                      itemExtent: 40,
                      onSelectedItemChanged: (selectionIndex) {
                        setState(() {
                          if (selectionIndex == 0) {
                            _frequency = const Duration(minutes: 2);
                          } else if (selectionIndex == 1) {
                            _frequency = const Duration(minutes: 5);
                          } else if (selectionIndex == 2) {
                            _frequency = const Duration(minutes: 30);
                          } else if (selectionIndex == 3) {
                            _frequency = const Duration(hours: 6);
                          } else if (selectionIndex == 4) {
                            _frequency = const Duration(days: 1);
                          } else {
                            _frequency = const Duration(days: 30);
                          }
                        });
                      },
                      children: const [
                        Text("2 minutes"),
                        Text("5 minutes"),
                        Text("30 minutes"),
                        Text("6 hours"),
                        Text("1 day"),
                        Text("1 month"),
                      ],
                    )),
                  ),
                  const Text(
                      "As of October 18th, there are FOUR test surveys available"),
                  const Text(
                      "For the sake of testing, please select a frequency for how often you want to test surveys"),
                  const Text(
                      "When deployed to production, there will be an interval of one month per survey, but at this moment, I am allowing for more frequent testing"),
                  const Text(
                      "Note, upon entering the app, the first survey will be immediately available, and ONLY available during the time span that you have selected"),
                  const Text(
                      "In the Future, development should only schedule subsequent surveys ONLY after the first survey is completed"),
                  const Text(
                      "This will allow for users in production to be able to start the first survey at any time"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orange),
                      ),
                      onPressed: enterApp,
                      child: const Text('Enter App'),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
