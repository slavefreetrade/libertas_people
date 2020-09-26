import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../models/profile_query_model.dart';
import '../shared/form_fields/app_form_field.dart';

class MultiSelectFormPage extends StatefulWidget {
  final ProfileFormQuestionModel formQuestion;
  const MultiSelectFormPage(this.formQuestion, {Key key}) : super(key: key);

  @override
  _MultiSelectFormPageState createState() => _MultiSelectFormPageState();
}

class _MultiSelectFormPageState extends State<MultiSelectFormPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _verticalDivider(),
        _buildTitle(),
        _verticalDivider(),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (_, __) => _verticalDivider(),
              itemBuilder: (_, index) => AppFormField(
                  label: widget.formQuestion.options[index],
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isSelected: widget.formQuestion.selectedIndex != null
                      ? widget.formQuestion.selectedIndex == index
                      : false),
              itemCount: widget.formQuestion.options.length),
        ),
        _verticalDivider(),
      ],
    );
  }

  Row _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.formQuestion.isOptional)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '*',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          ),
        Flexible(child: Text(
          widget.formQuestion.question,
          softWrap: true,
          style: const TextStyle(
              color: ColorConstants.darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        )),
      ],
    );
  }

  SizedBox _verticalDivider() => const SizedBox(height: 20);
}
