# libertaspeople

## Overview

In it's current state, this application is capable of creating a user automatically on the device, and allows that user to take surveys pulled in from the Qualtrics API. 

#### Sections:
0) Project Setup
1) Survey Management (for developers)
2) Survey Management (for Qualtrics Administrators)
3) User Identification
4) Current Outstanding Work and Bugs
5) Architecture:
    - Repositories and Usecases
    - Data Sources
    - Cubit State management
    - SetState state management
    - Additional Notes

### 0. Project Setup
Make sure to have Android Studio installed and the Flutter SDK. This is the official documentation for installing Flutter on your platform.

In assets/ directory, make sure you add a secrets.json file and copy in the appropriate datacenter and apiKey json contents. secrets.json is referenced in the .gitignore and should not be committed to source control. If the api key is compromised, a new api key can be generated via the Qualtrics Dashboard. 

### 1. Survey Management (for developers)
The user's device is responsible for keeping track of which survey needs to be taken at which moment. A Json blob is stored of all of the surveys (labled "Survey_<number>") and whether that survey has been completed or not, start/end dates etc. (See libertas_people/assets/mock_data/survey_list_for_local_storage.json for an example). 

The Qualtrics API does not allow for user management for survey takers. Looking forward in the future, a microservice may be necessary to manage users, and send out custom push notifications to their devices. The above json file could be copied in the microservice along to a reference for each user.

Currently, an entire survey session is stored on the device locally, with its questions, possible responses, and answers to be submitted. Upon completing the last question, the application tries to send the survey response in one API request to qualtrics.

Upon success, the user is notified, the current session is deleted from the phone, and the survey's 'completed' boolean is updated in the survey_list_for_local_storage.json file.

If their is a failure to submit the survey (due to a lack of service) the user will be notified, but the survey is not automatically sent to Qualtics (See outstanding work below)

### 2. Survey Management (Qualtrics Administrators)
There are a few things to note when creating new surveys within the Qualtrics Dashboard.

The dashboard allows you to edit the question ID's (QID) for each survey question, but I would not rely on the dashboard to properly update the QID behind the scenes. The API will return the old QIDs to the mobile application and the question order will potentially be disorganized.

My recommendation (albeit it is a pain) is to verify that you have the proper order of your questions before you create the survey. In development I have had to delete a survey completely to restructure the order of the questions. Luckily the 10 question surveys are not too long to type back in. (There may be different ways for the App to handle the survey order, but for now, unfortunately, this will be required).

The application currently only handles one block for a survey. Also, the app does not support skip logic (answer question #2 a certain way and skip to question #5). That will require editing of the app logic if that functionality is desired. 

To link a survey to a user, we are sending the deviceID (as a Unique Device ID) in the headers of the survey submission. Make sure you set 'Embedded Data' for each survey. To add this, within the edit screen for a survey, select 'Survey Flow' -> add 'Embedded Data' -> create a field for 'deviceID'. Make sure to keep 'deviceID' in the proper case (avoid entering 'deviceId' or 'deviceid')

### 3. User Identification
Currently User Identificatiohttps://github.com/slavefreetradegithub/libertas_people/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-descn (UID) is handled by a Unique Device ID, which is generated whenever a user downloads an application. The issue with this current solution for UID, is that when a user deletes the app from their phone, they will lose their UID, and basically have to start the entire years survey over. This can work in the short term for testing, but for production, there should be a more stable solution for UID that allows to accomodate user anonymity. 

The plan for production was for a survey to be available for each month, but for now, the user will be able to select the interval of how frequently they can take the survey (to allow for more rapid testing). 

### 4. Oustanding Work and Bugs

#### UI Pages to implement
1) Language Selection Page
2) Survey Information Page (before first survey)
3) About Libertas People page/tab off of the home screen
4) Clean up Appearance of About Survey Page/tab off of home screen
5) Onboarding Pages


#### Bugs
1) Hitting back button when on About Survey Page/Tab when a survey is in session but not completed pops you into the Survey, which is not the expected behavior. You should go back to the home screen from that navigation. I believe this issue has to do with how the navigation is being 'pushed' and 'popped' when exiting the survey. Try using Push replacement to leave the survey

2) There is a bug where if you dont answer the 1st question and you leave the session, and then return to that session, you will go to the second survey question while leaving the first question unanswered. All other cases upon leaving hte survey incomplete will correctly send you to the next incomplete answer. Look at the 
getNextQuestionForIncompleteSurvey() function in repository.dart.

#### Outstanding features
1) Update survey frequency upon completion of first survey - currently the survey frequency is set in the QualtricsLocalDataSource.storeSurveyList function(). This is called in Repository.fetchAndStoreQualtricsSurvey() which is called upon user creation. in QualtricsLocalDataSource.storeSurveyList, I would pull out the funcitonality that sets the date time for begin and end dates for each survey, and implment that instead as a seperate LocalDataSource call when calling Repository.completeSession (upon completing the first survey)

2) background syncing 
3) local notifications
4) internationalization
5) more stable user identificaion with anonymity
6) microservice with user management, survey management, and push notifications

## Architecture

### DataSources
There are 3 data sources, Qualtrics Remote, Qualtrics Local, and User Local.

Qualtrics Remote holds functions that are reponsible for communicating with the Qualtrics API directly. This includes starting a session, fetching lists of surveys, submitting a survey, etc. Make sure that you include a secrets.json file in your project for the api to work as expected.

Qualtrics Local holds functions that are responsible for storing survey and session data locally on the device. Currently the app manages a survey session locally and the Qualtrics Local datasource is responsible for updating that local session with submitted answers, fetching previous answers and questions, etc. It also is responsible for storing lists of surveys that the user needs to complete.

User Local holds functions responsible for fetching and setting the deviceId (as the UID), and also storing language preferences. If you decide to implement an authentication process that involves a micro service, I recommend creating a User Remote datasource to handle any api calls.  

### Repository and Usecases
Currently there is only one repository class and it is located in lib/data_layer. This repository holds functions that execute usecases. These usecase calls will pull and push data to and from the appropriate data sources, and allow the developer to call the usecases anywhere in the app. There are some instances where a repository is called directly in a widget, and there are instances where a Cubit will call the repository. 

It doesnt matter what state management is used for a feature, ideally these repository calls could be called from any state manager(Widgets, Change Notifiers, Blocs, and Cubits)


### Cubit (with BlocBuilder/Listener/Provider widgets)





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
