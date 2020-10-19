import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/features/home/home_page.dart';

class SelectSurveyFrequencyPage extends StatefulWidget {
  @override
  _SelectSurveyFrequencyPageState createState() =>
      _SelectSurveyFrequencyPageState();
}

class _SelectSurveyFrequencyPageState extends State<SelectSurveyFrequencyPage> {
  final Repository repo = Repository();

  Duration _frequency = Duration(minutes: 2);

  bool _isLoading = false;

  _enterApp() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      await repo.createUser();
      await repo.fetchAndStoreQualtricsSurveys(_frequency.inMinutes);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Select Survey Frequency"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                  child: CupertinoPicker(
                magnification: 1.5,
                itemExtent: 40,
                children: [
                  Text("2 minutes"),
                  Text("5 minutes"),
                  Text("30 minutes"),
                  Text("6 hours"),
                  Text("1 day"),
                  Text("1 month"),
                ],
                onSelectedItemChanged: (selectionIndex) {
                  setState(() {
                    if (selectionIndex == 0) {
                      _frequency = Duration(minutes: 2);
                    } else if (selectionIndex == 1) {
                      _frequency = Duration(minutes: 5);
                    } else if (selectionIndex == 2) {
                      _frequency = Duration(minutes: 30);
                    } else if (selectionIndex == 3) {
                      _frequency = Duration(hours: 6);
                    } else if (selectionIndex == 4) {
                      _frequency = Duration(days: 1);
                    } else {
                      _frequency = Duration(days: 30);
                    }
                  });
                  print("selectionIndex: ${selectionIndex}");
                },
              )),
            ),
            Text("As of October 18th, there are FOUR test surveys available"),
            Text(
                "For the sake of testing, please select a frequency for how often you want to test surveys"),
            Text(
                "When deployed to production, there will be an interval of one month per survey, but at this moment, I am allowing for more frequent testing"),
            Text(
                "Note, upon entering the app, the first survey will be immediately available, and ONLY available during the time span that you have selected"),
            Text(
                "In the Future, development should only schedule subsequent surveys ONLY after the first survey is completed"),
            Text(
                "This will allow for users in production to be able to start the first survey at any time"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: ColorConstants.orange,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text("Enter App"),
                onPressed: _enterApp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
