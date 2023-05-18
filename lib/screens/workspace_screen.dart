import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/services/html_extractor.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/models/Note.dart';
import 'package:project/utils/utils.dart';

// ignore: must_be_immutable
class WorkSpaceScreen extends StatefulWidget {
  static const route = '/workspace-screen';
  final Note note;
  bool isNewNote = false;
  Category category;
  WorkSpaceScreen(
      {super.key,
      required this.note,
      this.isNewNote = false,
      this.category = Category.simple});

  @override
  State<WorkSpaceScreen> createState() => _WorkSpaceScreenState();
}

class _WorkSpaceScreenState extends State<WorkSpaceScreen> {
  QuillEditorController? _controller;
  bool isLoadingTextEdit = true;
  bool isLoadingToolBar = true;
  Future? delay;
  NoteData? note_controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillEditorController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    note_controller = Provider.of<NoteData>(context);
    note_controller!.setPageLoaded();
    setState(() {
      isLoadingTextEdit = false;
      isLoadingToolBar = false;
    });
    delay = Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      if (mounted) {
        setState(() {
          note_controller!.isPageLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  // Add Note
  Future createNote() async {
    final value = await _controller!.getText();
    note_controller!.addNote(
        Note(text: value, datetime: DateTime.now(), category: widget.category));
  }

  // Update Note
  Future updateNote() async {
    await _controller!.getText().then((value) {
      note_controller!.updateNote(widget.note, value);
    });
  }

  final customToolBarList = [
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo,
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.blockQuote,
    ToolBarStyle.align,
    ToolBarStyle.underline,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.image,
    ToolBarStyle.color
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (isLoadingTextEdit ||
                isLoadingToolBar ||
                note_controller!.isPageLoading) {
              return;
            } else {
              await _controller!.getPlainText().then((value) async {
                if (parseHtmlString(value).trim().isNotEmpty) {
                  if (widget.isNewNote) {
                    //Create new Note
                    await createNote();
                  } else {
                    if (value.toString().trim() != widget.note.text.trim()) {
                      await updateNote();
                    }
                    // Update old Note
                  }
                }
              }).whenComplete(() {
                if (mounted && !note_controller!.isPageLoading) {
                  Navigator.pushReplacementNamed(context, HomeScreen.route);
                }
              });
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog(
                    context: context,
                    text: 'Are you sure?\nNote will be permanently deleted!',
                    callback: () {
                      note_controller!.removeNote(widget.note);
                      Navigator.pop(context, HomeScreen);
                    });
              },
              icon: const Icon(
                Icons.delete,
                size: 26,
                color: Color.fromARGB(255, 145, 86, 82),
              )),
          const SizedBox(
            width: 30,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: primeColor,
        leadingWidth: 100,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(children: [
            !isLoadingToolBar
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ToolBar(
                        toolBarColor: secondaryColor,
                        toolBarConfig: customToolBarList,
                        alignment: WrapAlignment.center,
                        activeIconColor: Colors.green,
                        padding: const EdgeInsets.all(8),
                        iconSize: 24,
                        spacing: 10,
                        controller: _controller!),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            isLoadingTextEdit
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(''),
                  )
                : Expanded(
                    child: QuillHtmlEditor(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xff817F7F),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'MontserratMedium'),
                      onEditorCreated: () async {
                        if (!widget.isNewNote) {
                          await _controller!.setText(widget.note.text);
                        }
                      },
                      hintText: 'Unititled',
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      hintTextPadding: const EdgeInsets.only(left: 10),
                      hintTextStyle: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      controller: _controller!,
                      backgroundColor: secondaryColor,
                      minHeight: 500,
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}
