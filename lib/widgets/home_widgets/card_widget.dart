import 'package:flutter/material.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/models/Note.dart';
import 'package:project/screens/workspace_screen.dart';
import 'package:project/services/html_extractor.dart';
import 'package:project/utils/utils.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  final Note note;

  const CardWidget({super.key, required this.note});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  NoteData? note_controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    note_controller = Provider.of<NoteData>(context);
  }

  @override
  Widget build(BuildContext context) {
    String title =
        "${widget.note.category.name[0].toUpperCase()}${widget.note.category.name.substring(1)}";

    String path = identifyIconByCategory(widget.note.category);

    return GestureDetector(
      onDoubleTap: () {
        return;
      },
      onTap: () {
        if (!note_controller!.isPageLoading) {
          Future.delayed(const Duration(milliseconds: 500))
              .whenComplete(() => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WorkSpaceScreen(
                        note: widget.note,
                        isNewNote: false,
                      ))));
        } else {
          return;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.only(left: 18),
        width: 140,
        height: 140,
        decoration: BoxDecoration(
            color: framesColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 2,
                  color: Colors.grey,
                  offset: Offset(4, 5))
            ]),
        child: InkWell(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: 21,
                      overflow: TextOverflow.clip,
                      fontFamily: 'PlayFair',
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    parseHtmlString(widget.note.text),
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'MontserratMedium',
                        color: additionalColor,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 5,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, bottom: 5),
                    child: Image(
                      image: AssetImage(path),
                      color: secondaryColor,
                      width: 35,
                      height: 35,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
