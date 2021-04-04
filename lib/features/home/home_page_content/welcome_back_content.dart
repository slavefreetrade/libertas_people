import 'package:flutter/material.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

class WelcomeBackContent extends StatelessWidget {
  final String nextSurveyId;

  const WelcomeBackContent(this.nextSurveyId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).welcomeBack,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
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
                    child: Image.asset(AppImages.group129),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            S
                                .of(context)
                                .yourMonthlySurveyWith10BinaryQuestionsIsReady,
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
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(8),
                backgroundColor: MaterialStateProperty.all(AppColors.orange),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              onPressed: () {
                context.read<SurveyCubit>().startSurvey(nextSurveyId);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 15,
                ),
                child: BlocBuilder<SurveyCubit, SurveyState>(
                    builder: (context, state) {
                  if (state is LoadingSurveyState) {
                    return const CircularProgressIndicator();
                  }
                  return Text(S.of(context).takeSurvey);
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
