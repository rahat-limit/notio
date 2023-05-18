import 'package:flutter/material.dart';
import 'package:project/utils/utils.dart';

class FullWidthAddButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const FullWidthAddButton(
      {super.key, required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
              backgroundColor: framesColor),
          onPressed: callback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PlayFair'),
              ),
              const Image(
                image: AssetImage('assets/icons/add_note_icon.png'),
                width: 35,
                height: 35,
                fit: BoxFit.contain,
              )
            ],
          )),
    );
  }
}
