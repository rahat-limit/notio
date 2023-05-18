import 'package:flutter/material.dart';
import 'package:project/screens/auth_screen.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/intro_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstOpen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear(); - to see intro screen
    bool check = pref.getBool('seen') ?? false;
    if (check) {
      await AuthService().isAuthed().then((authed) {
        if (authed) {
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        } else {
          Navigator.pushReplacementNamed(context, AuthScreen.route);
        }
      });
    } else {
      pref.setBool('seen', true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, IntroScreen.route);
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstOpen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
