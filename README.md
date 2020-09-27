# libertaspeople

## APIs

Our application will be communicating with 3 datasource classes

Our datasources are responsible fetching and updating data from either REST APIS, or from somewhere in the local device

The data sources will be responsible for converting fetched JSON into Models

Please put your models in the lib/models/ folder

I added the json_serializable package if you would like to use it to create your to and from JSON functions easier

Here is pub.dev for that package as reference: https://pub.dev/packages/json_serializable

Mock JSON data is located in assets/mock_data/ 

1) QualtricsRemoteDataSource:
    - this handles all of the survey creation and storage of survey results
2) QualtricsLocalDataSource:
    - Will be managed with file system (please see lib/todo_practice_work/data/local_todo_data_source.dart for an example):
    - Data stored
        1) current Survey Information (see current_session_meta_data.json)
        2) A list of all of the surveys for the year (see survey_list_for_local_storage.json)
3) UserLocalDataSource:
    - Will use Secure Storage (https://pub.dev/packages/flutter_secure_storage)
      1) unique Identifier (device ID)
      2) preferred language
      

I will list function names, input parameters, any return values

NOTE: For testing, feel free to create a page with buttons to fire off these function calls

### QualtricsLocalDataSource Functions


1) storeSurveyList(survey_list_from_qualtrics.json)
    - You will take survey_list_from_qualtrics and convert it into survey_list_for_local_storage
    - First set how frequently a user will need to fill out surveys: 
        1) create var surveyInterval = Duration(days: 7) (this will change / for actual production it will be set to a month)

    - Next: For Survey_1, you will need to:
        1) set beginDate as DateTime.now()
        2) set endDate as beginDate + surveyInterval
        3) set completed to false
    - For Survey_2, you will need to: 
        1) get Survey_1's endDate
        2) set Survey_2's beginDate as Survey_1's endDate
        3) set Survey_3's endDate as beginDate + surveyInterval
    - Continue doing this for all of the surveys titled Survey_${number}
    - do not add other surveys to the json blob
    
    - Finally, store survey_map_for_local_storage.json into file system as a "survey_map.txt" file. (Please see lib/todo_practice_work/data/local_todo_data_source.dart for an example)
    
2) fetchNextSurveyId()
    1) get currentDateTime = DateTime.now()
    2) Fetch "survey_map.txt" and loop through all surveys 
    3) Starting at 1, check and see if isCompleted == True
    4) if false, check and see if currentDateTime is inbetween start and end dates
    5) if it is, return the surveyID
    6) otherwise, check the next survey in the same way

3) markSurveyAsComplete(String surveyID)
    - Find survey in survey_map.txt and mark complete as true

4) getPercentageOfSurveysComplete()
    - return percentage of incomplete surveys / completed surveys 

5) storeCurrentSessionData(Map current_session_meta_data.json)
    - store current_session_meta_data.json into a "current_session.txt" file
6) getCurrentSessionData()
    - fetch and return CurrentSession model
7) deleteCurrentSessionData()
    - delete "current_session.txt"    

### QualtricsRemoteDataSource Functions

- Please see sample project for implemetation details (I will add you to a sample repo so you can test)
- Store all functions inside of qualtrics_data_sources/qualtrics_remote_data_source.dart
- I have added the api_key and data_center to assets/secrets.json
- in the .gitignore, I added the that file so it will not be added to source control
- please follow this article on how to parse and access API key from assets (https://medium.com/@sokrato/storing-your-secret-keys-in-flutter-c0b9af1c0f69)
- also, Martina is the person in charge of the surveys, I will put you in contact with her in case you have any issues

1) startSession(String surveyID)
    - return parsed Model that is returned to you (session_info.json)
2) getCurrentSession(current_session_meta_data.json)
    - return parsed Model that is returned to you (session_info.json)

3) updateSession(current_session_meta_data.json, mc_answer.json OR!!! text_answer.json)
    - return null if "done" in return object from API call == false
    - return "done" text if return object from API call == a string

4) getListOfAvailableSurveys()
    - return survey_list_from_qualtrics.json model
   
   
### UserLocalDataSource functions

1) storePreferredLanguage(String preferredLanguage)
    - store preferredLanguage in Flutter Secure Storage 
2) getPreferredLanguage()
    - read and return preferredLanguage from Secure Storage
3) storeUID(String uniqueDeviceId)
    - fetch uniqueDeviceID (https://pub.dev/packages/device_info)
    - store in Secure storage
4) getUID()
    - read and return uniqueDeviceId from secure storage
   
## Repositories

We will have two repositories, a UserRepository and a Qualtrics Repositroy

The UserRepository will call functions that call functions in the UserLocalDataSource
(and in the future, it will also call UserRemoteDataSource functions)

The same thing will happen for the QualtricsRepository. It will call functions in the 
QualtricsLocalDataSource class as well as the QualtricsRemoteDataSourceClass


### QualtricsRepository

### UserRepository