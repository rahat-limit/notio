import 'package:flutter/material.dart';
import 'package:project/screens/auth_screen.dart';
import 'package:project/widgets/full_width_button.dart';

class IntroScreen extends StatelessWidget {
  static const route = '/intro-screen';
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/icons/greetings.png'),
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Notio',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.6,
                              fontFamily: 'PlayFair'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/icons/intro_logo.png',
                    width: 120,
                    height: 120,
                  ),
                )
              ],
            ),
            const Text(
              'The best way to keep \nidea`s alive.',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            FullWithButton(
              text: 'Let`s Start!',
              callback: () =>
                  Navigator.pushReplacementNamed(context, AuthScreen.route),
            ),
          ],
        ),
      ),
    ));
  }
}
