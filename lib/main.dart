import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/environment_config.dart';

import 'package:libertaspeople/features/home/home_cubit.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

import 'features/splash_screen.dart';
import 'generated/l10n.dart';
import 'shared_ui_elements/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => SurveyCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: !EnvironmentConfig.isProd,
        title: 'Libertas People',
        localizationsDelegates: const [
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          backgroundColor: AppColors.backgroundColor,
          primarySwatch: Colors.blue,
          fontFamily: AppFonts.roboto,
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.zero,
            height: 50,
            minWidth: 30,
            textTheme: ButtonTextTheme.primary,
          ),
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: AppColors.darkBlue,
            elevation: 0,
            textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: AppFonts.roboto,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
