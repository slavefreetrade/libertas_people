import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnfinishedSurveyContent extends StatelessWidget {
  final String surveyId;
  final String sessionId;

  UnfinishedSurveyContent({
    @required this.surveyId,
    @required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You have a survey that has not been completed",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColors.greyAboutPage,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      child: Image.asset('assets/icons/Group 129.png'),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Your survey for the month is unfinished. Please take a few minutes to finish it.",
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
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
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: BlocBuilder<SurveyCubit, SurveyState>(
                      builder: (context, state) {
                    if (state is LoadingSurveyState) {
                      return CircularProgressIndicator();
                    }
                    return Text("Finish Survey");
                  }),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 40.0, vertical: 0),
                //   child: Text("Finish Survey"),
                // ),
                onPressed: () {
                  context.bloc<SurveyCubit>().returnToIncompleteSurveySession(
                      surveyId: surveyId, sessionId: sessionId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
