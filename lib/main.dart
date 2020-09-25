import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:libertaspeople/pages/profile_creation/shared/fonts/app_fonts.dart';

import 'constants/colors.dart';
import 'generated/l10n.dart';
import 'pages/ui_development_page.dart';


void main() {
  runApp(
   DevicePreview(
     enabled: false, //!kReleaseMode,
     builder: (context) =>
          MyApp(),
   ),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libertas People',
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        backgroundColor: ColorConstants.backgroundColor,
        primarySwatch: Colors.blue,
        fontFamily: AppFonts.helveticaNeue,
        buttonTheme: const ButtonThemeData(
          padding: EdgeInsets.zero,
          height: 50,
          minWidth: 30,
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme: const AppBarTheme(
          color: ColorConstants.backgroundColor,
          centerTitle: true,
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
                color: ColorConstants.orange,
                fontFamily: AppFonts.helveticaNeue,
                fontSize: 32,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      home: UIDevelopmentPage(),
    );
  }
}
