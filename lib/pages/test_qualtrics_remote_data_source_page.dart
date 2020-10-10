import 'package:flutter/material.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/models/api_request_model.dart';
import 'package:libertaspeople/models/survey_reponses_model.dart';

class TestQualtricsRemoteDataSourcePage extends StatefulWidget {
  final QualtricsRemoteDataSource dataSource;
  TestQualtricsRemoteDataSourcePage({Key key, @required this.dataSource})
      : super(key: key);

  @override
  _TestQualtricsRemoteDataSourcePageState createState() =>
      _TestQualtricsRemoteDataSourcePageState();
}

class _TestQualtricsRemoteDataSourcePageState
    extends State<TestQualtricsRemoteDataSourcePage> {
  QualtricsRemoteDataSource get dataSource => widget.dataSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test remote data source screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("fetch survey list"),
              onPressed: () async {
                try {
                  var response = await dataSource.getListOfAvailableSurveys();
                  // print(
                  //     "response returned ${response.elements.map((e) => e.toJson())}");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("fetch new session"),
              onPressed: () async {
                try {
                  String surveyId = "SV_af0aK21x6XGzcYl";
                  final ApiRequestModel request =
                      ApiRequestModel(surveyId: surveyId);
                  var response = await dataSource.startSession(surveyId);
                  print("response returned ${response.toJson()}");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("fetch Current Session"),
              onPressed: () async {
                print("fetching current session: ");
                try {
                  String surveyId = "SV_af0aK21x6XGzcYl";
                  String sessionId = "FS_3CZC0rA4TeBd0tA";

                  var response = await dataSource.getCurrentSession(
                      surveyId: surveyId, sessionId: sessionId);
                  print("response returned ${response.toJson()}");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("answer text question"),
              onPressed: () async {
                try {
                  String surveyId = "SV_af0aK21x6XGzcYl";
                  String sessionId = "FS_3CZC0rA4TeBd0tA";
                  final ApiRequestModel request =
                      ApiRequestModel(surveyId: surveyId, sessionId: sessionId);
                  final SurveyResponsesModel answers = SurveyResponsesModel(
                      deviceId: 'UID on device',
                      advance: false,
                      answers: {"QID8": "workplaceID"});
                  var response = await dataSource.updateSession(
                      request: request, surveyResponses: answers);
                  print("response returned: $response");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("answer mc question"),
              onPressed: () async {
                try {
                  String surveyId = "SV_af0aK21x6XGzcYl";
                  String sessionId = "FS_3CZC0rA4TeBd0tA";
                  final ApiRequestModel request =
                      ApiRequestModel(surveyId: surveyId, sessionId: sessionId);
                  final SurveyResponsesModel answers = SurveyResponsesModel(
                      deviceId: 'UID on device',
                      advance: false,
                      answers: {
                        "QID4": {
                          "2": {"selected": true}
                        }
                      });
                  var response = await dataSource.updateSession(
                      request: request, surveyResponses: answers);
                  print("response returned: $response");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
