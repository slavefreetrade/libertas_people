import 'package:flutter_test/flutter_test.dart';
import 'package:libertaspeople/models/choice_model.dart';
import 'package:libertaspeople/models/survey_list_item_model.dart';

void main() {
  group('Survey Model', () {
    test('mapping model from json', () {
      final surveyItem = SurveyListItemModel.fromJson(_mockJsonData);

      expect(surveyItem.name, equals(_mockJsonData['name']));
      expect(surveyItem.id, equals(_mockJsonData['id']));
      expect(surveyItem.isActive, equals(_mockJsonData['isActive']));
    });

    test('mapping model to json', () {
      final surveyItem =
          SurveyListItemModel(id: '1', name: 'surveyName', isActive: false);
      final surveyItemJson = surveyItem.toJson();

      expect(surveyItemJson['id'], equals(surveyItem.id));
      expect(surveyItemJson['name'], equals(surveyItem.name));
      expect(surveyItemJson['isActive'], equals(surveyItem.isActive));
    });

    test('mapping model from json', () {
      final surveyList = SurveyListModel.fromJson(_mockListJsonData);

      expect(surveyList.surveys.map((e) => e.toJson()).toList(),
          equals(_mockListJsonData['surveys']));
    });

    test('mapping model to json', () {
      final surveyList = SurveyListModel(
        surveys: [SurveyListItemModel(isActive: true, name: 'survey', id: '2')],
      );
      final surveyListJson = surveyList.toJson();

      expect(surveyListJson['surveys'],
          equals(surveyList.surveys.map((e) => e.toJson()).toList()));
    });
  });
}

const _mockJsonData = {
  'id': 'gklndshgdsglkn',
  'name': 'Survey_2',
  'isActive': true
};

const _mockListJsonData = {
  'surveys': [
    {'id': 'gklndshgdsglkn', 'name': 'Survey_2', 'isActive': true},
    {'id': 'PK_asgdmnantkp', 'name': 'Survey_1', 'isActive': true},
    {'id': 'ALNFoafnjdsglkn', 'name': 'Survey_3', 'isActive': true},
    {'id': 'SV_bslkMpW1tsMStkp', 'name': 'Survey_4', 'isActive': true},
    {
      'id': 'SV_d0WdqcyYmdkeqMZ',
      'name': 'Test Survey do not add this to local db!',
      'isActive': true
    }
  ]
};
