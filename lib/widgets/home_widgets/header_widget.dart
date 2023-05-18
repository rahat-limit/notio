import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String text;
  final String font;
  final IconData icon;
  final double padding;
  final double size;

  const HeaderWidget(
      {super.key,
      required this.text,
      this.font = 'MontserratMedium',
      this.icon = Icons.bookmark_border,
      this.padding = 20,
      this.size = 19});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          text,
          style: TextStyle(
              fontSize: size, fontFamily: font, fontWeight: FontWeight.w300),
        ),
        Icon(
          icon,
          size: 27,
        )
      ]),
    );
  }
}
