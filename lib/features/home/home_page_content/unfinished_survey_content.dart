import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

class UnfinishedSurveyContent extends StatelessWidget {
  final String surveyId;
  final String sessionId;

  const UnfinishedSurveyContent({
    @required this.surveyId,
    @required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).youHaveASurveyThatHasNotBeenCompleted,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          softWrap: true,
        ),
        const SizedBox(height: 16),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.greyAboutPage,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  child: SvgPicture.asset(AppImages.yesNo2Svg),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          S
                              .of(context)
                              .yourSurveyForTheMonthIsUnfinishedPleaseTakeAFewMinutesToFinishIt,
                          softWrap: true,
                          style: const TextStyle(
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
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<SurveyCubit, SurveyState>(builder: (context, state) {
          if (state is LoadingSurveyState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: ButtonOrangeColor(
                label: S.of(context).finishSurvey,
                onPressed: () {
                  context.read<SurveyCubit>().returnToIncompleteSurveySession(
                      surveyId: surveyId, sessionId: sessionId);
                },
              ),
            );
          }
        }),
      ],
    );
  }
}
