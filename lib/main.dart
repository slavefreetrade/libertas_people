import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:libertaspeople/features/home/home_cubit.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/shared_ui_elements/fonts/app_fonts.dart';

import 'constants/colors.dart';
import 'features/splash_screen.dart';
import 'generated/l10n.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: false, //!kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
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
        title: 'Libertas People',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          backgroundColor: AppColors.backgroundColor,
          primarySwatch: Colors.blue,
          fontFamily: AppFonts.helveticaNeue,
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.zero,
            height: 50,
            minWidth: 30,
            textTheme: ButtonTextTheme.primary,
          ),
          appBarTheme: const AppBarTheme(
            color: AppColors.darkBlue,
            elevation: 0,
            textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: AppFonts.helveticaNeue,
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

//
// void main() {
//   runApp(
//     DevicePreview(
//       enabled: false, //!kReleaseMode,
//       builder: (context) => MyApp(),
//     ),
//   );
// }
//
// // ignore: use_key_in_widget_constructors
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeScreenCubit(),
//       child: MaterialApp(
//         title: 'Libertas People',
//         // ignore: prefer_const_literals_to_create_immutables
//         localizationsDelegates: [
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           S.delegate,
//         ],
//         supportedLocales: S.delegate.supportedLocales,
//         theme: ThemeData(
//           backgroundColor: ColorConstants.backgroundColor,
//           primarySwatch: Colors.blue,
//           fontFamily: AppFonts.helveticaNeue,
//           buttonTheme: const ButtonThemeData(
//             padding: EdgeInsets.zero,
//             height: 50,
//             minWidth: 30,
//             textTheme: ButtonTextTheme.primary,
//           ),
//           appBarTheme: const AppBarTheme(
//             color: ColorConstants.darkBlue,
// //          centerTitle: true,
//             elevation: 0,
//             textTheme: TextTheme(
//               headline6: TextStyle(
//                   fontFamily: AppFonts.helveticaNeue,
//                   fontSize: 28,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ),
//         // home: SplashScreen(),
//         home: HomePage(),
//
//         // initialRoute: '/',
//         // routes: {
//         //   '/': (ctx) => UIDevelopmentPage(),
//         //   SurveyQuestionPage.routeName: (ctx) => SurveyQuestionPage(),
//         //   ThankyouPage.routeName: (ctx) => ThankyouPage(),
//         //   SurveyThankyouPage.routeName: (ctx) => SurveyThankyouPage()
//         // },
//       ),
//     );
//   }
// }
