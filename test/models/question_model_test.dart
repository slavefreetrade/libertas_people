import 'package:flutter_test/flutter_test.dart';
import 'package:libertaspeople/models/choice_model.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/question_options_model.dart';

void main() {
  group('Question Model', () {
    test('mapping model from json', () {
      final question = QuestionModel.fromJson(_mockJsonData);

      expect(question.questionId, equals(_mockJsonData['questionId']));
      expect(question.type.toString().split('.').last,
          equals(_mockJsonData['type']));
      expect(question.display, equals(_mockJsonData['display']));
      expect(question.options.toJson(), equals(_mockJsonData['options']));
      expect(question.choices.map((e) => e.toJson()).toList(),
          equals(_mockJsonData['choices']));
    });

    test('mapping model to json', () {
      final question = QuestionModel(
        questionId: 'QID2',
        type: QuestionType.mc,
        display: '*What is your gender?',
        options: QuestionOptionsModel(multiSelect: false, columnLabels: []),
        choices: [ChoiceModel(display: 'Male', choiceId: '1', textual: false)],
      );
      final questionJson = question.toJson();

      expect(questionJson['questionId'], equals(question.questionId));
      expect(questionJson['type'],
          equals(question.type.toString().split('.').last));
      expect(questionJson['display'], equals(question.display));
      expect(questionJson['options'], equals(question.options.toJson()));
      expect(questionJson['choices'],
          equals(question.choices.map((e) => e.toJson()).toList()));
    });
  });
}

const _mockJsonData = {
  'questionId': 'QID2',
  'type': 'mc',
  'display': '*What is your gender?',
  'options': {'columnLabels': <String>[], 'multiSelect': false},
  'choices': [
    {'choiceId': '1', 'display': 'Male', 'textual': false},
    {'choiceId': '2', 'display': 'Female', 'textual': false},
    {'choiceId': '3', 'display': 'Other', 'textual': false},
    {'choiceId': '4', 'display': 'Prefer not to say', 'textual': false}
  ]
};
