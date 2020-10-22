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
    - View models with Cubit

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
- Update survey frequency upon completion of first survey. Currently the survey frequency is set in the QualtricsLocalDataSource.storeSurveyList function(). This is called in Repository.fetchAndStoreQualtricsSurvey() which is called upon user creation. in QualtricsLocalDataSource.storeSurveyList, I would pull out the funcitonality that sets the date time for begin and end dates for each survey, and implment that instead as a seperate LocalDataSource call when calling Repository.completeSession (upon completing the first survey)

- Background Syncing. With how the survey session is stored and managed locally up until submission, there is a chance that the submission will fail due to a network time out or no network available. If that is the case, I think it would be a useful feature to implement https://pub.dev/packages/background_fetch to have the app automatically try to resend that survey. Basically you should be able to call Repository.completeSession() within the background fetch call back. 

- local notifications. This could be implemented to notify the user that a background fetch sucessfully calling Repository.completeSession() has occurred. https://pub.dev/packages/flutter_local_notifications

- internationalization. Refactor out text strings from app. Support Desired languages. The beginning of this is already implemented

- A more stable user identificaion process with anonymity. The current user identification (with a unique device ID) may make it difficult to submit to apple for review. Also, that unique device id will change if the user deletes and reinstalls the application, which will create old accounts

- Microservice with user management, survey management, and push notifications. The QualtricsLocalDataSource currently manages all of the survey 

### 5. Architecture

#### DataSources
There are 3 data sources, Qualtrics Remote, Qualtrics Local, and User Local.

Qualtrics Remote holds functions that are reponsible for communicating with the Qualtrics API directly. This includes starting a session, fetching lists of surveys, submitting a survey, etc. Make sure that you include a secrets.json file in your project for the api to work as expected.

Qualtrics Local holds functions that are responsible for storing survey and session data locally on the device. Currently the app manages a survey session locally and the Qualtrics Local datasource is responsible for updating that local session with submitted answers, fetching previous answers and questions, etc. It also is responsible for storing lists of surveys that the user needs to complete.

User Local holds functions responsible for fetching and setting the deviceId (as the UID), and also storing language preferences. If you decide to implement an authentication process that involves a micro service, I recommend creating a User Remote datasource to handle any api calls.  

#### Repository and Usecases
Currently there is only one repository class and it is located in lib/data_layer. This repository holds functions that execute usecases. These usecase calls will pull and push data to and from the appropriate data sources, and allow the developer to call the usecases anywhere in the app. There are some instances where a repository is called directly in a widget, and there are instances where a Cubit will call the repository. 

It doesnt matter what state management is used for a feature, ideally these repository calls could be called from any state manager(Widgets, Change Notifiers, Blocs, and Cubits)


#### ViewModels with Cubit (and BlocBuilder/Listener/Provider widgets)

View Models are representations of the state of a feature, without it being connected to the actual UI code. I have used Cubit in this app, but you could also use Bloc, RiverPod, Change Notifiers, the list goes on and on. 

Basically the View Models help keep UI code clean and only responsible for displaying views and accepting user interaction. 

Some simple states can be managed with Statefuly widgets.

Cubit and Bloc are basically the same thing. If you see Bloc anywhere, just know that it Bloc widgets work with Cubits. 

There is a HomeScreenCubit and Survey Cubit. They both manage the state for their respective feature.

##### States
First, define an abstract state for the Cubit, ("SurveyState" for example). Then add all of the states that the feature will be in as classes that extend the abstract state (LoadingHomeScreenState or FailureHomeScreenState). In the super constructor of the Cubit, put in the intial state of the Cubit (UninitializedHomeScreenState() for example).

Next, Create functions that represent user interaction in the Cubit (HomeScreenCubit only has one - loadHomeScreen(), SurveyCubit has many more). These are the functions that will be called from somewhere in the UI code (although you could reference another Cubit from a different cubit and call its functions, that gets pretty hard to keep track of).

When one of these functions is called, repository calls will fetch, set, update, and delete data as you would like. When the feature needs to be notified of a state change ('hey we waited for the data, now lets present it') you can emit() a state. Normally, you will emit a LoadingState first when you call these functions, process some repository calls, and then emit a Loaded state if no exceptions are thrown or a Failed State if there are errors. 

The HomeScreenCubit has multiple "success" states (WelcomeFirstTimeHomeScreenState, WelcomeBackHomeScreenState, etc.)

You can use Enums, primitive data types or Classes to represent states. Classes work really well because you can add fields that hold any data you want to utilize for that state. 

Note: The creators of bloc recommend you use Value typing like (https://pub.dev/packages/equatable) but I havent seemed to have needed it. I believe the concern is if you emit the same state twice, the widgets listening to these changes will not update because they hold referential equality. If you make them value types though, they wont be the same object in memory, so the widgets will rebuild. If you emit a Loading State at the beginning of each Cubit function call though, you should not run into this issue. 

##### Integrate Cubit State into UI
1) Bloc Provider - above the MaterialApp() class in main, use either a BlocProvider or a MultiBlocProvider to provide the Cubit (Or Bloc) View Model to the rest of the app.

2) call a Cubit function - context.bloc<HomeScreenCubit>().loadHomeScreen() will tell the HomeScreen Cubit to call that function. Just doing this will not change the UI, but the View Model will begin processing and emitting states. (you can also use BlocProvider.of<HomeScreenState>(context).loadHomeScreen() to do the same thing)
    
3) BlocBuilders are UI widgets that will update whenever a Cubit or Bloc's state changes. The builder function contains the build context and the state. Do if checks on the state to decide what you want to render. See home_page.dart for an example on how different Home states are rendered.

4) BlocListeners are UI widgets that will perform an action based on a state change. Navigation, animations, snackbars can be triggered from responses to state changes inside of the BlocListener. Make sure to wrap the body of a Scaffold, not the scaffold itself if you want to perform navigations for a scaffold (Keep the listeners below the scaffold level). See survey_question_page.dart to see how navigation within the Survey Feature behaves.
