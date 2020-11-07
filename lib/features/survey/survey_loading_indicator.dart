import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';

class SurveyLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(builder: (context, state) {
      if (state is LoadingSurveyState) {
        return Container(
          color: Colors.black38,
          child: Center(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
            ),
            width: 150,
            height: 150,
            // color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(S.of(context).loading),
                  CircularProgressIndicator(
                    backgroundColor: AppColors.orange,
                  ),
                ],
              ),
            ),
          )),
        );
      }
      return Container();
    });
  }
}
