import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        image: AssetImage('assets/icons/auth_logo.png'),
        height: 100,
        width: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}
