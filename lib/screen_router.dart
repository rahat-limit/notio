import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/account_screen.dart';
import 'package:project/screens/auth_screen.dart';
import 'package:project/screens/forgot_screen.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/intro_screen.dart';
import 'package:project/screens/splash_screen.dart';

class ScreenRouter extends StatelessWidget {
  const ScreenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      )),
      debugShowCheckedModeBanner: false,
      home: const Center(
        child: CircularProgressIndicator(),
      ),
      initialRoute: SplashScreen.route,
      routes: {
        AuthScreen.route: (context) => const AuthScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        SplashScreen.route: (context) => const SplashScreen(),
        IntroScreen.route: (context) => const IntroScreen(),
        ForgotScreen.route: (context) => const ForgotScreen(),
        AccountScreen.route: (context) => const AccountScreen(),
      },
    );
  }
}
