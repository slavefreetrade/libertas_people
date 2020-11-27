import 'package:flutter_test/flutter_test.dart';
import 'package:libertaspeople/models/choice_model.dart';

void main() {
  group('Choice Model', () {
    test('mapping model from json', () {
      final choice = ChoiceModel.fromJson(_mockJsonData);

      expect(choice.choiceId, equals(_mockJsonData['choiceId']));
      expect(choice.display, equals(_mockJsonData['display']));
      expect(choice.textual, equals(_mockJsonData['textual']));
    });

    test('mapping model to json', () {
      final choice = ChoiceModel(choiceId: '1', display: 'Male', textual: false);
      final choiceJson = choice.toJson();

      expect(choiceJson['choiceId'], equals(choice.choiceId));
      expect(choiceJson['display'], equals(choice.display));
      expect(choiceJson['textual'], equals(choice.textual));
    });
  });
}

const _mockJsonData = {
  'choiceId': '1',
  'display': 'Male',
  'textual': false
};
