import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/account_screen.dart';
import 'package:project/utils/utils.dart';

class AppBarWidget extends StatelessWidget {
  final String email;
  const AppBarWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'N',
          style: TextStyle(
              color: primeColor,
              fontFamily: 'PlayFair',
              fontSize: 57,
              fontWeight: FontWeight.w600),
        ),
        Container(
          width: double.minPositive,
          constraints: const BoxConstraints(maxWidth: 250, minWidth: 180),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                foregroundColor: primeColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                side: const BorderSide(
                  width: 1,
                )),
            onPressed: () {
              Navigator.pushNamed(context, AccountScreen.route);
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      email,
                      style: const TextStyle(
                          fontFamily: 'PlayFair', fontWeight: FontWeight.w600),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(CupertinoIcons.person)
                ]),
          ),
        ),
      ],
    );
  }
}
