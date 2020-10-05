import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libertaspeople/models/secret_model.dart';

class TestQualtricsRemoteAPIPage extends StatefulWidget {


  @override
  _TestQualtricsRemoteAPIPageState createState() =>
      _TestQualtricsRemoteAPIPageState();
}

class _TestQualtricsRemoteAPIPageState
    extends State<TestQualtricsRemoteAPIPage> {
  int _counter = 0;
  String sessionId;

  String surveyId = "SV_af0aK21x6XGzcYl";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Test Qualtrics API"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("fetch survey list"),
              onPressed: () async {
                try {
                  final SecretModel secrets = await SecretModel.load();
                  String apiKey = secrets.apiKey;
                  String dataCenter = secrets.dataCenter;
                  Map<String, String> headers = {
                    "x-api-token": apiKey,
                    "Content-Type": "application/json"
                  };
                  var response = await http.get(
                    "https://$dataCenter.qualtrics.com/API/v3/surveys",
                    headers: headers,
                  );

                  print("response code: ${response.statusCode}");
                  print("response body: ${response.body}");
                  sessionId = jsonDecode(response.body)['result']['sessionId'];
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("fetch new session"),
              onPressed: () async {
                try {
                  final SecretModel secrets = await SecretModel.load();
                  String apiKey = secrets.apiKey;
                  String dataCenter = secrets.dataCenter;
                  Map<String, String> headers = {
                    "x-api-token": apiKey,
                    "Content-Type": "application/json"
                  };
                  Map<String, String> body = {'language': "EN"};
                  var response = await http.post(
                      "https://$dataCenter.qualtrics.com/API/v3/surveys/$surveyId/sessions",
                      headers: headers,
                      body: json.encode(body));

                  print("response code: ${response.statusCode}");
                  print("response body: ${response.body}");
                  sessionId = jsonDecode(response.body)['result']['sessionId'];
                  log("sessionId = $sessionId");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("fetch Current Session"),
              onPressed: () async {
                print("fetching current session: $sessionId");
                try {
                  final SecretModel secrets = await SecretModel.load();
                  String apiKey = secrets.apiKey;
                  String dataCenter = secrets.dataCenter;
                  Map<String, String> headers = {
                    "x-api-token": apiKey,
                    "Content-Type": "application/json"
                  };

                  var response = await http.get(
                    "https://$dataCenter.qualtrics.com/API/v3/surveys/$surveyId/sessions/$sessionId",
                    headers: headers,
                  );

                  print("response code: ${response.statusCode}");
                  Map map = jsonDecode(response.body);
                  debugPrint("body: ${map}", wrapWidth: 1024);


                  sessionId = map['result']['sessionId'];
                  print(map['result']['responses']);
                  log("sessionId = $sessionId");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("answer text question"),
              onPressed: () async {
                try {
                  final SecretModel secrets = await SecretModel.load();
                  String apiKey = secrets.apiKey;
                  String dataCenter = secrets.dataCenter;
                  String surveyId = "SV_bslkMpW1tsMStkp";
                  Map<String, String> headers = {
                    "x-api-token": apiKey,
                    "Content-Type": "application/json"
                  };
                  Map<String, dynamic> body = {
//                    'language': "EN",
                    "embeddedData": {"deviceID": "UID on device"},
                    "advance": false, // I Think advance means finish..?
                    "responses": {"QID1": "workplaceID"}
                  };
                  var response = await http.post(
                      "https://$dataCenter.qualtrics.com/API/v3/surveys/$surveyId/sessions/$sessionId",
                      headers: headers,
                      body: json.encode(body));

                  print("response code: ${response.statusCode}");
                  log("response body: ${response.body}");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
            RaisedButton(
              child: Text("answer mc question"),
              onPressed: () async {
                try {
                  final SecretModel secrets = await SecretModel.load();
                  String apiKey = secrets.apiKey;
                  String dataCenter = secrets.dataCenter;
                  String surveyId = "SV_bslkMpW1tsMStkp";
                  Map<String, String> headers = {
                    "x-api-token": apiKey,
                    "Content-Type": "application/json"
                  };
                  Map<String, dynamic> body = {
//                    'language': "EN",
                    "embeddedData": {"deviceID": "UID on device"},
                    "advance": false, // I Think advance means finish..?
                    "responses": {
                      "QID2": {
                        "2": {"selected": true}
                      }
                    }
                  };
                  var response = await http.post(
                      "https://$dataCenter.qualtrics.com/API/v3/surveys/$surveyId/sessions/$sessionId",
                      headers: headers,
                      body: json.encode(body));

                  print("response code: ${response.statusCode}");
                  log("response body: ${response.body}");
                } catch (e) {
                  print("exception: $e");
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
