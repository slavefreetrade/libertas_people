import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/features/survey/lauguage_selection_page.dart';

class WelcomeFirstTimeContent extends StatefulWidget {
  final String firstSurveyId;

  const WelcomeFirstTimeContent(this.firstSurveyId);

  @override
  _WelcomeFirstTimeContentState createState() => _WelcomeFirstTimeContentState();
}

class _WelcomeFirstTimeContentState extends State<WelcomeFirstTimeContent> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome onboard!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "We are happy that you want to take part in our survey that plays an important part in monitoring human rights conditions at work places.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
            SizedBox(
              height: 13,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 11.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          child: Image.asset('assets/icons/ima.png'),
                        ),
                        Text(
                          "Always anonymous",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        child: Image.asset('assets/icons/i.png'),
                      ),
                      Text(
                        "Only binary questions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        child: Image.asset('assets/icons/im.png'),
                      ),
                      Flexible(
                        child: Text(
                          "Less than five minutes to complete",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                color: AppColors.orange,
                highlightElevation: 2,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                  child: _isLoading ? CircularProgressIndicator():  Text("Take Survey"),
                ),
                onPressed: () {
                  setState((){_isLoading = true;});
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          LanguageSelectionPage(widget.firstSurveyId)));
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
