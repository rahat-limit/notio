import 'package:flutter/material.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/models/Note.dart';
import 'package:project/screens/workspace_screen.dart';
import 'package:project/services/html_extractor.dart';
import 'package:project/utils/utils.dart';
import 'package:provider/provider.dart';

class ExpansionItem extends StatelessWidget {
  final Note note;
  const ExpansionItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    NoteData note_controller = Provider.of<NoteData>(context);
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: secondaryColor,
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onDoubleTap: () {
                      return;
                    },
                    onTap: () async {
                      if (!note_controller.isPageLoading) {
                        await Future.delayed(const Duration(seconds: 1))
                            .whenComplete(() => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WorkSpaceScreen(note: note))));
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        parseHtmlString(note_controller.getNotes
                            .firstWhere((element) => element.id == note.id)
                            .text),
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 17,
                            color: secondaryColor,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                showAlertDialog(
                    context: context,
                    text: 'Are you sure?\nNote will be permanently deleted!',
                    callback: () {
                      note_controller.removeNote(note);
                    });
              },
              icon: Icon(
                Icons.delete,
                color: secondaryColor,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 30),
          child: Divider(
            thickness: .09,
            color: secondaryColor,
          ),
        )
      ],
    );
  }
}
