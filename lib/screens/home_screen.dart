import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/models/Note.dart';
import 'package:project/screens/auth_screen.dart';
import 'package:project/screens/workspace_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/utils.dart';
import 'package:project/widgets/ad_widgets/ad_banner.dart';
import 'package:project/widgets/home_widgets/appbar_widget.dart';
import 'package:project/widgets/home_widgets/card_list_widget.dart';
import 'package:project/widgets/home_widgets/expansion_tile.dart';
import 'package:project/widgets/home_widgets/full_width_add_button.dart';
import 'package:project/widgets/home_widgets/header_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;
  NoteData? note_controller;

  Future checkFirstOpen() async {
    await AuthService().isAuthed().then((authed) {
      if (!authed) {
        Navigator.pushReplacementNamed(context, AuthScreen.route);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkFirstOpen();
    currentUser = FirebaseAuth.instance.currentUser;
    note_controller = Provider.of<NoteData>(context);
    when((p0) => note_controller!.getNotes.isEmpty, () {
      note_controller!.getStorageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    void addNewNote() {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(actions: [
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () => showDialogd(
                    context,
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 32,
                      scrollController: FixedExtentScrollController(
                        initialItem: currentIndex,
                      ),
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          currentIndex = selectedItem;
                        });
                      },
                      children: List<Widget>.generate(Category.values.length,
                          (int index) {
                        return Center(child: Text(Category.values[index].name));
                      }),
                    )),
                child: const Text('Choose category:'),
              ),
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 500))
                      .whenComplete(() => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkSpaceScreen(
                                  note: Note.init(),
                                  isNewNote: true,
                                  category: identifyByIndex(currentIndex)))));
                },
                child: const Text('Select'),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Отмена'),
              ),
            ]);
          });
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: AppBarWidget(email: currentUser!.email!),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: HeaderWidget(text: 'Recent Notes:'),
                  ),
                  const CardList(),
                  const Padding(
                    padding: EdgeInsets.only(right: 30.0, left: 5, bottom: 20),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  FullWidthAddButton(text: 'New Note', callback: addNewNote),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 30, left: 10),
                    child: HeaderWidget(text: 'All Notes:'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: ExpansionTileWidget())
                ],
              ),
            ),
          )),
          const AdBannerWidget()
        ]),
      )),
    );
  }
}
