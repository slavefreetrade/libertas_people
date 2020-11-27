import 'package:flutter_test/flutter_test.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/question_options_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';

void main() {
  group('Survey Response Model', () {
    test('mapping model from json', () {
      final sessionInfo = SessionInfoModel.fromJson(_mockJsonData);

      expect(sessionInfo.sessionId, equals(_mockJsonData['sessionId']));
      expect(sessionInfo.questions.map((e) => e.toJson()).toList(),
          equals(_mockJsonData['questions']));
      expect(sessionInfo.done, equals(_mockJsonData['done']));
      expect(sessionInfo.responses, equals(_mockJsonData['responses']));
    });

    test('mapping model to json', () {
      final sessionInfo = SessionInfoModel(
          questions: [
            QuestionModel(
                display: 'Enter your workplace code',
                type: QuestionType.te,
                questionId: 'QID7',
                options: QuestionOptionsModel())
          ],
          done: false,
          sessionId: 'FS_6DpmZGOa9wRpimd',
          responses: <String, dynamic>{});
      final sessionInfoJson = sessionInfo.toJson();

      expect(sessionInfoJson['sessionId'], equals(sessionInfo.sessionId));
      expect(sessionInfoJson['done'], equals(sessionInfo.done));
      expect(sessionInfoJson['questions'],
          equals(sessionInfo.questions.map((e) => e.toJson()).toList()));
      expect(sessionInfoJson['responses'], equals(sessionInfo.responses));
    });
  });
}

const _mockJsonData = {
  'sessionId': 'FS_6DpmZGOa9wRpimd',
  'questions': [
    {
      'questionId': 'QID7',
      'type': 'te',
      'display': 'Enter your workplace code',
      'options': <String, dynamic>{}
    },
    {
      'questionId': 'QID11',
      'type': 'mc',
      'display': 'Gender',
      'options': {'columnLabels': <String>[], 'multiSelect': false},
      'choices': [
        {'choiceId': '1', 'display': 'male', 'textual': false},
        {'choiceId': '2', 'display': 'Female', 'textual': false},
        {'choiceId': '4', 'display': 'other', 'textual': false},
        {'choiceId': '5', 'display': 'non disclose', 'textual': false}
      ]
    },
    {
      'questionId': 'QID12',
      'type': 'te',
      'display': 'unique user id',
      'options': <String, dynamic>{}
    }
  ],
  'responses': <String, dynamic>{},
  'done': false
};
