import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/models/Note.dart';
import 'package:project/utils/utils.dart';
import 'package:project/widgets/home_widgets/item_expansion.dart';
import 'package:provider/provider.dart';

class ExpansionTileWidget extends StatefulWidget {
  const ExpansionTileWidget({super.key});

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  // ignore: non_constant_identifier_names
  NoteData? note_conrtoller;
  Iterable<Note>? _list;

  String? title;
  List<ExpansionItem>? items;
  String? iconPath;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    note_conrtoller = Provider.of<NoteData>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        warnWhenNoObservables: false,
        builder: (context) {
          return Column(
            children: List.generate(Category.values.length, (index) {
              title = identifyTitleByCategory(Category.values[index]);
              iconPath = identifyIconByCategory(Category.values[index]);
              _list =
                  note_conrtoller!.getNotesByCategory(Category.values[index]);
              List<ExpansionItem> listItems =
                  List.generate(_list!.length, (idx) {
                return ExpansionItem(note: _list!.elementAt(idx));
              });

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ExpansionTile(
                    initiallyExpanded: index == 0 ? true : false,
                    tilePadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    iconColor: secondaryColor,
                    collapsedIconColor: secondaryColor,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    collapsedBackgroundColor: framesColor,
                    backgroundColor: framesColor,
                    childrenPadding: const EdgeInsets.only(left: 15),
                    leading: Image.asset(
                      iconPath!,
                      width: 35,
                      height: 35,
                      color: secondaryColor,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      title!,
                      style: TextStyle(
                          fontFamily: 'PlayFair',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: secondaryColor),
                    ),
                    children: listItems),
              );
            }),
          );
        });
  }
}
