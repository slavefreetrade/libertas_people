import 'package:flutter_test/flutter_test.dart';
import 'package:libertaspeople/models/question_options_model.dart';

void main() {
  group('Question Options Model', () {
    test('mapping model from json', () {
      final questionOptions = QuestionOptionsModel.fromJson(_mockJsonData);

      expect(questionOptions.columnLabels, equals(_mockJsonData['columnLabels']));
      expect(questionOptions.multiSelect, equals(_mockJsonData['multiSelect']));
    });

    test('mapping model to json', () {
      final questionOptions = QuestionOptionsModel(columnLabels: [], multiSelect: true);
      final questionOptionsJson = questionOptions.toJson();

      expect(questionOptionsJson['columnLabels'], equals(questionOptions.columnLabels));
      expect(questionOptionsJson['multiSelect'], equals(questionOptions.multiSelect));
    });
  });
}

const _mockJsonData = {
  'columnLabels': <String>[],
  'multiSelect': false
};
