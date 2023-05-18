import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final VoidCallback callback;
  const ActionButtonWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.callback,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(width: 1.5, color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 25),
        ),
        onPressed: callback,
        child: Row(
          children: [
            Expanded(
                child: Text(
              text,
              maxLines: 1,
              style: TextStyle(
                  color: color, fontFamily: 'MontserratMedium', fontSize: 16),
            )),
            Icon(
              icon,
              size: 26,
              color: color,
            )
          ],
        ));
  }
}
