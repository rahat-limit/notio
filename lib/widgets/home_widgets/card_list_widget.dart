import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/models/Note.dart';
import 'package:project/widgets/home_widgets/card_widget.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  NoteData? note_controller;
  List<Note>? _recentNotes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    note_controller = Provider.of<NoteData>(context);
    _recentNotes = note_controller!.getRecentNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SizedBox(
        width: double.infinity,
        height: 180,
        child: _recentNotes!.isEmpty
            ? Center(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/icons/tumbleweed.png'),
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Create new notes to start!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  )
                ],
              ))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                scrollDirection: Axis.horizontal,
                itemCount: _recentNotes!.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                    note: _recentNotes![index],
                  );
                },
              ),
      );
    });
  }
}
