import 'package:flutter/material.dart';
import 'package:project/utils/utils.dart';

class ButtonWidget extends StatelessWidget {
  final String type;
  final String text;
  final VoidCallback callback;
  const ButtonWidget(
      {super.key,
      required this.type,
      required this.text,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: framesColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 25)),
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                type,
                maxLines: 1,
                style: TextStyle(color: linkColor, fontSize: 17),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 3,
              child: Text(
                text,
                maxLines: 1,
                softWrap: true,
                style:
                    const TextStyle(overflow: TextOverflow.clip, fontSize: 18),
              ),
            )
          ],
        ));
  }
}
