import 'package:flutter/material.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';
import 'package:libertaspeople/shared_ui_elements/images.dart';

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
              S.of(context).youHaveASurveyThatHasNotBeenCompleted,
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
                      child: Image.asset(AppImages.group129),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              S.of(context).yourSurveyForTheMonthIsUnfinishedPleaseTakeAFewMinutesToFinishIt,
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
                    return Text(S.of(context).finishSurvey);
                  }),
                ),
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
